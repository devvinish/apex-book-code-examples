select 'Sales this month' as label,
       to_char(sum(order_total), 'FML999G999G990') as value,
       'fa-line-chart' as icon,
       count(*) || ' orders' as detail
  from orb_orders
 where order_date >= trunc(sysdate, 'MM')
   and status <> 'CANCELLED'
union all
select 'Average order',
       to_char(avg(order_total), 'FML999G990D00'),
       'fa-shopping-cart',
       'last 30 days'
  from orb_orders
 where order_date >= trunc(sysdate) - 30
   and status <> 'CANCELLED'
union all
select 'Awaiting approval',
       to_char(count(*)),
       'fa-clock-o',
       'orders pending'
  from orb_orders
 where status = 'PENDING_APPROVAL'
union all
select 'Products to reorder',
       to_char(count(*)),
       'fa-exclamation-triangle',
       'below reorder level'
  from orb_products_v
 where needs_reorder = 'Y'
