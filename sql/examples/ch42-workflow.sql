-- Workflow "Order Fulfillment", version 1.0: Additional Data (SQL Query)
select o.order_id,
       o.order_number,
       o.order_total,
       o.status,
       c.customer_name
  from orb_orders o
  join orb_customers c on c.customer_id = o.customer_id
 where o.order_id = :APEX$WORKFLOW_DETAIL_PK

-- Activity "Reserve Stock" (Execute Code)
begin
    orb_sales.add_order_note(:APEX$WORKFLOW_DETAIL_PK, 'Stock reserved');
end;

-- Activity "Prepare Invoice" (Execute Code)
begin
    orb_sales.add_order_note(:APEX$WORKFLOW_DETAIL_PK, 'Invoice prepared');
end;

-- Activity "Ship Order" (Execute Code)
begin
    orb_sales.ship_order(p_order_id => :APEX$WORKFLOW_DETAIL_PK);
end;
