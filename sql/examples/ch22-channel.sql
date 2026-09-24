select initcap(replace(channel, '_', ' ')) as channel,
       sum(order_total)                    as sales
  from orb_orders
 where status <> 'CANCELLED'
 group by channel
