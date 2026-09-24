select trunc(order_date, 'MM') as sales_month,
       sum(order_total)        as sales,
       count(*)                as orders
  from orb_orders
 where status <> 'CANCELLED'
   and order_date >= add_months(trunc(sysdate, 'MM'), -11)
 group by trunc(order_date, 'MM')
