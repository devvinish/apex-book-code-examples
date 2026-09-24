select o.order_id,
       o.order_number,
       c.customer_name,
       to_char(o.order_total, 'FM$999G999G990D00') as order_total,
       o.discount_pct
  from orb_orders o
  join orb_customers c on c.customer_id = o.customer_id
 where o.status = 'PENDING_APPROVAL'
