select 1
  from orb_orders
 where order_id = :P10_ORDER_ID
   and status   = 'PENDING_APPROVAL'
