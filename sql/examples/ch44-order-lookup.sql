select o.order_number,
       o.status,
       o.order_date,
       o.order_total,
       o.discount_pct,
       c.customer_name,
       e.employee_name as sales_rep
  from orb_orders o
  join orb_customers c on c.customer_id = o.customer_id
  left join orb_employees e on e.employee_id = o.sales_rep_id
 where o.order_number = upper(:ORDER_NUMBER)
