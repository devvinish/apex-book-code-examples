-- @session app=200 page=2 user=ADMIN
declare
    l_region_id number := apex_region.get_id(p_page_id => 2, p_dom_static_id => 'customers');
begin
    apex_region.reset(p_page_id => 2, p_region_id => l_region_id);   -- report settings back to the default
    apex_region.clear(p_page_id => 2, p_region_id => l_region_id);   -- pagination and IR settings of the session
    dbms_output.put_line('read-only: ' || nvl(case apex_region.is_read_only when true then 'yes' when false then 'no' end, '(no region)'));
    dbms_output.put_line('cache date: ' || nvl(to_char(apex_region.get_cache_date(200, 2, 'customers')), '(not cached)'));
    apex_region.purge_cache(p_application_id => 200, p_page_id => 2, p_region_id => l_region_id);
    dbms_output.put_line('done');
end;
/
