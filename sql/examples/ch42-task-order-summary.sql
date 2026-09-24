select o.order_number  as "Order",
       c.customer_name as "Customer",
       e.employee_name as "Sales Rep",
       o.order_total   as "Order Total",
       o.discount_pct  as "Discount %"
  from orb_orders o
  join orb_customers c on c.customer_id = o.customer_id
  left join orb_employees e on e.employee_id = o.sales_rep_id
 where o.order_id = (select detail_pk
                       from apex_tasks
                      where task_id = :P54_TASK_ID)
