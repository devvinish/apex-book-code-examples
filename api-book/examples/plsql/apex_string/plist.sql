declare
    l_plist apex_t_varchar2 := apex_t_varchar2();       -- a property list: key, value, key, value
begin
    apex_string.plist_put(l_plist, 'status', 'SHIPPED');
    apex_string.plist_put(l_plist, 'carrier', 'UPS');
    apex_string.plist_put(l_plist, 'status', 'DELIVERED');          -- replaces the value
    apex_string.plist_push(l_plist, 'note', 'left at door');        -- adds without checking
    dbms_output.put_line('status:  ' || apex_string.plist_get(l_plist, 'status'));
    dbms_output.put_line('exists:  ' || case when apex_string.plist_exists(l_plist, 'carrier') then 'carrier' end);
    dbms_output.put_line('key of UPS: ' || apex_string.plist_get_key(l_plist, 'UPS'));
    apex_string.plist_delete(l_plist, 'carrier');
    dbms_output.put_line('json:    ' || apex_string.plist_to_json_clob(l_plist));
end;
/
