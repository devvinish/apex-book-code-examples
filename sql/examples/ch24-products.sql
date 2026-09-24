select p.product_name, sum(i.quantity) as units, sum(i.line_total) as spent
  from orb_order_items i
  join orb_orders o   on o.order_id = i.order_id
  join orb_products p on p.product_id = i.product_id
 where o.customer_id = :P19_CUSTOMER_ID
   and o.status <> 'CANCELLED'
 group by p.product_name
 order by spent desc
