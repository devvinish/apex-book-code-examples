-- @session app=200 page=1
select config_label, title, subtitle, badge
  from table(apex_search.search(p_search_static_ids => apex_t_varchar2('products', 'customers'),
                                p_search_expression => 'trail tent'))
 fetch first 5 rows only;
