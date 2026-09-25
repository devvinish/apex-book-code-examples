-- @session app=200 page=1
declare
    l_context apex_exec.t_context;
begin
    l_context := apex_exec.open_query_context(
                     p_location  => apex_exec.c_location_local_db,
                     p_sql_query => 'select category_id, category_name
                                       from orb_categories
                                      where parent_category_id is null
                                      order by category_id
                                      fetch first 2 rows only');
    apex_json.initialize_clob_output(p_indent => 1);
    apex_json.open_object;
    apex_json.write_context(p_name => 'categories', p_context => l_context);
    apex_json.close_object;
    dbms_output.put_line(apex_json.get_clob_output(p_free => true));
    apex_exec.close(l_context);
end;
/
