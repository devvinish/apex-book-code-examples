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
