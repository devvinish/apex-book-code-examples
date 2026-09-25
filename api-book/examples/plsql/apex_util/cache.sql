-- @session app=200 page=1 user=ADMIN
begin
    dbms_output.put_line('page cache:   ' || nvl(to_char(apex_util.cache_get_date_of_page_cache(200, 1)), '(none)'));
    dbms_output.put_line('region cache: ' || nvl(to_char(apex_util.cache_get_date_of_region_cache(200, 1, 'Recent Orders')), '(none)'));
    apex_util.cache_purge_by_page(p_application => 200, p_page => 1);
    apex_util.cache_purge_stale(p_application => 200);
    apex_util.cache_purge_by_application(p_application => 200);
    apex_util.purge_regions_by_name(p_application => 200, p_page => 1, p_region_name => 'Recent Orders');
    apex_util.purge_regions_by_page(p_application => 200, p_page => 1);
    apex_util.purge_regions_by_app(p_application => 200);
    dbms_output.put_line('purged');
end;
/
