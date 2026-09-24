select null as row_selector,
       order_id,
       order_number,
       order_date,
       customer_name,
       customer_city,
       sales_rep,
       region,
       channel,
       status_label as status,
       item_count,
       order_total,
       shipped_date
  from orb_orders_v
