select order_id,
       order_number || ' · ' || customer_name as title,
       required_date,
       status_label,
       case status
         when 'PENDING_APPROVAL' then 'apex-cal-yellow'
         when 'APPROVED'         then 'apex-cal-blue'
         when 'SHIPPED'          then 'apex-cal-green'
         when 'DELIVERED'        then 'apex-cal-gray'
         when 'CANCELLED'        then 'apex-cal-red'
         else                         'apex-cal-orange'
       end as css_class
  from orb_orders_v
 where required_date is not null
