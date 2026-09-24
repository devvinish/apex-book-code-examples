select c.customer_id,
       c.customer_name,
       c.customer_type,
       c.city,
       c.loyalty_tier,
       case c.loyalty_tier
         when 'PLATINUM' then 'tier-platinum'
         when 'GOLD'     then 'tier-gold'
         when 'SILVER'   then 'tier-silver'
         else                 'tier-bronze'
       end                  as tier_class,
       count(o.order_id)    as orders,
       sum(o.order_total)   as total_sales,
       max(o.order_date)    as last_order
  from orb_customers c
  join orb_orders o
    on o.customer_id = c.customer_id
 where o.status <> 'CANCELLED'
 group by c.customer_id, c.customer_name, c.customer_type,
          c.city, c.loyalty_tier
