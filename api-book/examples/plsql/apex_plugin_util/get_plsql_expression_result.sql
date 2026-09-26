-- @session app=200 page=20
begin
    apex_session_state.set_value('P20_NUMBER', '12');
    -- code a developer typed into a plug-in attribute, with bind variables
    dbms_output.put_line(apex_plugin_util.get_plsql_expression_result(':P20_NUMBER * 2'));
    dbms_output.put_line(case when apex_plugin_util.get_plsql_expr_result_boolean(':P20_NUMBER > 10') then 'true' end);
    dbms_output.put_line(apex_plugin_util.get_plsql_function_result(
        'declare l_n number; begin select count(*) into l_n from orb_orders where status = ''NEW''; return l_n || '' new''; end;'));
    dbms_output.put_line(dbms_lob.getlength(apex_plugin_util.get_plsql_func_result_clob(
        'declare l_c clob; begin for i in 1 .. 20 loop l_c := l_c || rpad(''x'', 2000, ''x''); end loop; return l_c; end;'))
        || ' characters');

    dbms_output.put_line(apex_plugin_util.replace_substitutions('Hello &APP_USER., you entered &P20_NUMBER.'));
    dbms_output.put_line(apex_plugin_util.escape('<b>Tent</b>', p_escape => true));
    dbms_output.put_line(apex_plugin_util.get_html_attr('data-sku', 'TNT-1002'));
    dbms_output.put_line(apex_plugin_util.get_search_string(apex_plugin_util.c_search_contains_ignore, 'Tent'));
    dbms_output.put_line(case when apex_plugin_util.is_equal(null, null) then 'null = null' end);
    dbms_output.put_line(apex_plugin_util.get_attribute_as_number('42', 'Max. Stars'));
    begin
        dbms_output.put_line(apex_plugin_util.get_attribute_as_number('four', 'Max. Stars'));
    exception when others then
        dbms_output.put_line(regexp_replace(sqlerrm, 'ORA-\d+: '));
    end;
end;
/
