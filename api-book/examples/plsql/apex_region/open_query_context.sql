-- @session app=200 page=2 user=ADMIN
declare
    l_context apex_exec.t_context;
begin
    l_context := apex_region.open_query_context(
        p_page_id   => 2,
        p_region_id => apex_region.get_id(p_page_id => 2, p_dom_static_id => 'customers'),
        p_max_rows  => 3,
        p_total_row_count => true);
    dbms_output.put_line('rows in the report: ' || apex_exec.get_total_row_count(l_context));
    while apex_exec.next_row(l_context) loop
        dbms_output.put_line(apex_exec.get_varchar2(l_context, 'FIRST_NAME') || ' '
            || apex_exec.get_varchar2(l_context, 'LAST_NAME') || ' - '
            || apex_exec.get_varchar2(l_context, 'CITY'));
    end loop;
    apex_exec.close(l_context);
end;
/
