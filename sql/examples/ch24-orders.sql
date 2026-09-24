select order_number, order_date, status_label as status,
       item_count as items, order_total
  from orb_orders_v
 where customer_id = :P19_CUSTOMER_ID
 order by order_date desc
