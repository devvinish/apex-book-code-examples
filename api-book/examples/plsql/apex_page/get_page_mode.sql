-- @session app=200 page=1 user=ADMIN
begin
    dbms_output.put_line('page 2: ' || apex_page.get_page_mode(p_application_id => 200, p_page_id => 2));
    dbms_output.put_line('page 3: ' || apex_page.get_page_mode(p_application_id => 200, p_page_id => 3));
    dbms_output.put_line('read-only: ' || case when apex_page.is_read_only then 'yes' else 'no' end);
    dbms_output.put_line('cache date: ' || nvl(to_char(apex_page.get_cache_date(200, 1)), '(not cached)'));
    apex_page.purge_cache(p_application_id => 200, p_page_id => 1);
    dbms_output.put_line('purged');
end;
/
