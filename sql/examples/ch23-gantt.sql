select p.promotion_id,
       p.promotion_name,
       nvl(c.category_name, 'All products')        as category,
       cast(p.start_date as timestamp)             as start_date,
       cast(p.end_date + 1 as timestamp)           as end_date,
       p.discount_pct || '% off'                   as label,
       cast(min(p.start_date) over () as timestamp)   as timeline_start,
       cast(max(p.end_date + 1) over () as timestamp) as timeline_end
  from orb_promotions p
  left join orb_categories c on c.category_id = p.category_id
