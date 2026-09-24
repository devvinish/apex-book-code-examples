with nodes as (
    select 'C' || category_id                               as id,
           nvl2(parent_category_id, 'C' || parent_category_id, null) as parent_id,
           category_name                                    as title,
           'fa-folder-o'                                    as icon,
           null                                             as link,
           category_name                                    as sort_key
      from orb_categories
    union all
    select 'P' || product_id,
           'C' || category_id,
           product_name,
           'fa-tag',
           apex_page.get_url(p_page   => 12,
                             p_items  => 'P12_PRODUCT_ID',
                             p_values => product_id),
           product_name
      from orb_products
)
select case when connect_by_isleaf = 1 then 0
            when level = 1             then 1
            else                            -1
       end         as status,
       level,
       title,
       icon,
       id          as value,
       title       as tooltip,
       link
  from nodes
 start with parent_id is null
 connect by prior id = parent_id
 order siblings by sort_key
