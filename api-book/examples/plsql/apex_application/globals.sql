-- @session app=200 page=20 user=ADMIN
begin
    dbms_output.put_line('g_flow_id:      ' || apex_application.g_flow_id);
    dbms_output.put_line('g_flow_step_id: ' || apex_application.g_flow_step_id);
    dbms_output.put_line('g_user:         ' || apex_application.g_user);
    dbms_output.put_line('g_instance:     ' || case when apex_application.g_instance is not null then '(the session ID)' end);
    dbms_output.put_line('g_flow_alias:   ' || apex_application.g_flow_alias);
    dbms_output.put_line('g_debug:        ' || case when apex_application.g_debug then 'on' else 'off' end);
    dbms_output.put_line('g_request:      ' || nvl(apex_application.g_request, '(null)'));
    dbms_output.put_line('g_date_format:  ' || apex_application.g_date_format);
end;
/
