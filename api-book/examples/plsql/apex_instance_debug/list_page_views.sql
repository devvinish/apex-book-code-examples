-- @connect sysdba
begin
    -- instance-wide debugging, for administrators: is it on, and what did debugged requests log?
    dbms_output.put_line('instance debug: ' || case when apex_instance_debug.is_enabled then 'on' else 'off' end);
    apex_instance_debug.list_page_views(p_max_rows => 3);
end;
/
