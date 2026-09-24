-- Chapter 31: Ajax Callback GET_CUSTOMER_INFO (page 10)
declare
    l_customer_id orb_customers.customer_id%type := apex_application.g_x01;
begin
    apex_json.open_object;
    for c in (
        select c.credit_limit,
               orb_sales.customer_lifetime_value(c.customer_id) as lifetime_value,
               (select count(*)
                  from orb_orders o
                 where o.customer_id = c.customer_id
                   and o.status in ('NEW', 'PENDING_APPROVAL', 'APPROVED')) as open_orders
          from orb_customers c
         where c.customer_id = l_customer_id
    ) loop
        apex_json.write('creditLimit',   c.credit_limit);
        apex_json.write('lifetimeValue', c.lifetime_value);
        apex_json.write('openOrders',    c.open_orders);
    end loop;
    apex_json.close_object;
end;
