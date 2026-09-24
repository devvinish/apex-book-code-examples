-- Chapter 29: Approve Selected Orders (page 8, Execute Code, When Button Pressed: APPROVE)
for r in (
    select column_value as order_id
      from apex_string.split(:P8_SELECTED_ORDERS, ':')
) loop
    orb_sales.approve_order(p_order_id => r.order_id);
end loop;
