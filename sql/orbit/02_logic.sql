-- ============================================================================
-- Orbit Outfitters sample schema — triggers, package, and views
-- ============================================================================

-- Audit columns: who created and last changed a row. Inside APEX,
-- APEX$SESSION.APP_USER is the signed-in user; elsewhere it is the database user.
create or replace trigger orb_customers_biu
    before insert or update on orb_customers
    for each row
begin
    if inserting then
        :new.created_on := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION', 'APP_USER'), user);
    end if;
    :new.updated_on := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION', 'APP_USER'), user);
    :new.email := lower(:new.email);
end orb_customers_biu;
/

create or replace trigger orb_products_biu
    before insert or update on orb_products
    for each row
begin
    if inserting then
        :new.created_on := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION', 'APP_USER'), user);
    end if;
    :new.updated_on := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION', 'APP_USER'), user);
    :new.sku := upper(:new.sku);
end orb_products_biu;
/

create or replace trigger orb_orders_biu
    before insert or update on orb_orders
    for each row
declare
    l_lines number;
begin
    if inserting then
        :new.created_on := sysdate;
        :new.created_by := coalesce(sys_context('APEX$SESSION', 'APP_USER'), user);
    end if;
    -- A new order discount changes the order total.
    if updating('DISCOUNT_PCT') then
        select nvl(sum(line_total), 0) into l_lines
          from orb_order_items
         where order_id = :new.order_id;
        :new.order_total := round(l_lines * (1 - :new.discount_pct / 100), 2);
    end if;
    :new.updated_on := sysdate;
    :new.updated_by := coalesce(sys_context('APEX$SESSION', 'APP_USER'), user);
end orb_orders_biu;
/

create sequence orb_order_number_seq start with 10001 nocache;

create or replace package orb_sales as
    -- Next order number, e.g. ORD-10001.
    function next_order_number return varchar2;

    -- Recalculates ORB_ORDERS.ORDER_TOTAL from the order lines and the order discount.
    procedure recalc_order_total (p_order_id in number);

    -- Status changes with their business rules.
    procedure submit_order (p_order_id in number);
    procedure approve_order (p_order_id in number);
    procedure ship_order (p_order_id in number);
    procedure cancel_order (p_order_id in number, p_reason in varchar2 default null);

    -- Appends a time-stamped line to the order's notes.
    procedure add_order_note (p_order_id in number, p_note in varchar2);

    -- Orders with a discount above this percentage need a manager's approval.
    c_approval_discount_pct constant number := 10;

    -- Total value of a customer's delivered and shipped orders.
    function customer_lifetime_value (p_customer_id in number) return number;

    -- Quantity of a product across all warehouses.
    function stock_on_hand (p_product_id in number) return number;
end orb_sales;
/

create or replace package body orb_sales as

    function next_order_number return varchar2 is
    begin
        return 'ORD-' || orb_order_number_seq.nextval;
    end next_order_number;

    procedure recalc_order_total (p_order_id in number) is
    begin
        update orb_orders o
           set o.order_total = (
                   select round(nvl(sum(i.line_total), 0) * (1 - o.discount_pct / 100), 2)
                     from orb_order_items i
                    where i.order_id = o.order_id)
         where o.order_id = p_order_id;
    end recalc_order_total;

    procedure set_status (p_order_id in number, p_from in apex_t_varchar2, p_to in varchar2) is
        l_status orb_orders.status%type;
    begin
        select status into l_status from orb_orders where order_id = p_order_id for update;
        if l_status not member of p_from then
            raise_application_error(-20001,
                'Order cannot change from ' || l_status || ' to ' || p_to || '.');
        end if;
        update orb_orders
           set status = p_to,
               shipped_date = case when p_to = 'SHIPPED' then trunc(sysdate) else shipped_date end
         where order_id = p_order_id;
    end set_status;

    procedure submit_order (p_order_id in number) is
        l_discount orb_orders.discount_pct%type;
    begin
        select discount_pct into l_discount from orb_orders where order_id = p_order_id;
        set_status(p_order_id, apex_t_varchar2('NEW'),
                   case when l_discount > c_approval_discount_pct
                        then 'PENDING_APPROVAL' else 'APPROVED' end);
    end submit_order;

    procedure approve_order (p_order_id in number) is
    begin
        set_status(p_order_id, apex_t_varchar2('PENDING_APPROVAL'), 'APPROVED');
    end approve_order;

    procedure ship_order (p_order_id in number) is
    begin
        set_status(p_order_id, apex_t_varchar2('APPROVED'), 'SHIPPED');
    end ship_order;

    procedure cancel_order (p_order_id in number, p_reason in varchar2 default null) is
    begin
        set_status(p_order_id, apex_t_varchar2('NEW', 'PENDING_APPROVAL', 'APPROVED'), 'CANCELLED');
        if p_reason is not null then
            update orb_orders
               set notes = substr(notes || case when notes is not null then chr(10) end
                                  || 'Cancelled: ' || p_reason, 1, 4000)
             where order_id = p_order_id;
        end if;
    end cancel_order;

    procedure add_order_note (p_order_id in number, p_note in varchar2) is
    begin
        update orb_orders
           set notes = substr(notes || case when notes is not null then chr(10) end
                              || to_char(sysdate, 'YYYY-MM-DD HH24:MI') || ' ' || p_note, 1, 4000)
         where order_id = p_order_id;
    end add_order_note;

    function customer_lifetime_value (p_customer_id in number) return number is
        l_total number;
    begin
        select nvl(sum(order_total), 0)
          into l_total
          from orb_orders
         where customer_id = p_customer_id
           and status in ('SHIPPED', 'DELIVERED');
        return l_total;
    end customer_lifetime_value;

    function stock_on_hand (p_product_id in number) return number is
        l_qty number;
    begin
        select nvl(sum(quantity_on_hand), 0)
          into l_qty
          from orb_inventory
         where product_id = p_product_id;
        return l_qty;
    end stock_on_hand;

end orb_sales;
/

-- Keeps ORDER_TOTAL in step with the order lines. A compound trigger collects the
-- affected orders and recalculates each once, after the statement (avoiding ORA-04091).
create or replace trigger orb_order_items_total
    for insert or update or delete on orb_order_items
    compound trigger

    type t_ids is table of boolean index by pls_integer;
    g_orders t_ids;

    after each row is
    begin
        if inserting or updating then
            g_orders(:new.order_id) := true;
        end if;
        if deleting or updating then
            g_orders(:old.order_id) := true;
        end if;
    end after each row;

    after statement is
        l_id pls_integer := g_orders.first;
    begin
        while l_id is not null loop
            orb_sales.recalc_order_total(l_id);
            l_id := g_orders.next(l_id);
        end loop;
        g_orders.delete;
    end after statement;
end orb_order_items_total;
/

-- Added in Chapter 19: default line numbers and prices for new order lines.
create or replace trigger orb_order_items_bi
    before insert on orb_order_items
    for each row
begin
    -- Number the new line after the order's last line.
    if :new.line_no is null then
        select nvl(max(line_no), 0) + 1
          into :new.line_no
          from orb_order_items
         where order_id = :new.order_id;
    end if;
    -- Use the product's current price unless a price was entered.
    if :new.unit_price is null then
        select unit_price
          into :new.unit_price
          from orb_products
         where product_id = :new.product_id;
    end if;
end orb_order_items_bi;
/

-- --------------------------------------------------------------------------- views

create or replace view orb_orders_v as
select o.order_id,
       o.order_number,
       o.order_date,
       o.required_date,
       o.shipped_date,
       o.status,
       initcap(replace(o.status, '_', ' ')) as status_label,
       o.channel,
       o.payment_method,
       o.discount_pct,
       o.order_total,
       o.customer_id,
       c.customer_name,
       c.customer_type,
       c.city as customer_city,
       c.country_code as customer_country,
       o.sales_rep_id,
       e.employee_name as sales_rep,
       e.region,
       o.warehouse_id,
       w.warehouse_name,
       (select count(*) from orb_order_items i where i.order_id = o.order_id) as item_count
  from orb_orders o
  join orb_customers c on c.customer_id = o.customer_id
  left join orb_employees e on e.employee_id = o.sales_rep_id
  left join orb_warehouses w on w.warehouse_id = o.warehouse_id;

create or replace view orb_products_v as
select p.product_id,
       p.sku,
       p.product_name,
       p.category_id,
       c.category_name,
       pc.category_name as parent_category_name,
       p.supplier_id,
       s.supplier_name,
       p.unit_price,
       p.cost_price,
       p.unit_price - p.cost_price as margin,
       p.reorder_level,
       p.color,
       p.weight_kg,
       p.launch_date,
       p.is_active,
       nvl(i.stock, 0) as stock_on_hand,
       case when nvl(i.stock, 0) <= p.reorder_level then 'Y' else 'N' end as needs_reorder,
       r.avg_rating,
       nvl(r.review_count, 0) as review_count
  from orb_products p
  join orb_categories c on c.category_id = p.category_id
  left join orb_categories pc on pc.category_id = c.parent_category_id
  left join orb_suppliers s on s.supplier_id = p.supplier_id
  left join (select product_id, sum(quantity_on_hand) as stock
               from orb_inventory group by product_id) i on i.product_id = p.product_id
  left join (select product_id, round(avg(rating), 1) as avg_rating, count(*) as review_count
               from orb_product_reviews group by product_id) r on r.product_id = p.product_id;

create or replace view orb_sales_by_month_v as
select trunc(o.order_date, 'MM') as sales_month,
       c.category_name,
       pc.category_name as parent_category_name,
       e.region,
       count(distinct o.order_id) as order_count,
       sum(i.quantity) as units_sold,
       sum(i.line_total) as sales_amount
  from orb_orders o
  join orb_order_items i on i.order_id = o.order_id
  join orb_products p on p.product_id = i.product_id
  join orb_categories c on c.category_id = p.category_id
  left join orb_categories pc on pc.category_id = c.parent_category_id
  left join orb_employees e on e.employee_id = o.sales_rep_id
 where o.status <> 'CANCELLED'
 group by trunc(o.order_date, 'MM'), c.category_name, pc.category_name, e.region;
