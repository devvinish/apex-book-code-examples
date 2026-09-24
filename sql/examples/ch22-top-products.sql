select p.product_id,
       p.product_name,
       sum(i.line_total) as sales
  from orb_order_items i
  join orb_orders o   on o.order_id = i.order_id
  join orb_products p on p.product_id = i.product_id
 where o.status <> 'CANCELLED'
 group by p.product_id, p.product_name
 order by sales desc
 fetch first 10 rows only
