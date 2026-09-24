select v.product_id,
       v.sku,
       v.product_name,
       v.category_name,
       v.unit_price,
       to_char(v.unit_price, 'FML999G990D00') as price,
       v.stock_on_hand,
       v.avg_rating,
       v.review_count,
       v.needs_reorder,
       p.description,
       p.product_image,
       p.image_mime_type,
       p.image_updated_on
  from orb_products_v v
  join orb_products p
    on p.product_id = v.product_id
 where v.is_active
