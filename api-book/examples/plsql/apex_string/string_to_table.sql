declare
    l_tab apex_application_global.vc_arr2;
begin
    l_tab := apex_string.string_to_table('Red:Olive:Sand');       -- the old PL/SQL table type
    dbms_output.put_line('rows: ' || l_tab.count || ', second: ' || l_tab(2));
    dbms_output.put_line('table_to_string: ' || apex_string.table_to_string(l_tab, ' - '));
    dbms_output.put_line('table_to_clob:   ' || replace(apex_string.table_to_clob(l_tab), chr(10), '\n'));
end;
/
