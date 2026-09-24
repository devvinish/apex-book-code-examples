select orb_sales.stock_on_hand(product_id) as stock_on_hand,
       reorder_level,
       4 * reorder_level                   as stock_target
  from orb_products
 where product_id = :P12_PRODUCT_ID
