-- @session app=200 page=1 user=ADMIN
begin
    owa.init_cgi_env(4, owa.vc_arr('REQUEST_PROTOCOL', 'SERVER_NAME', 'SERVER_PORT', 'SCRIPT_NAME'),
                        owa.vc_arr('https', 'apex.orbit-outfitters.example', '443', '/ords'));   -- as in a request
    dbms_output.put_line('host_url:              ' || apex_util.host_url);
    dbms_output.put_line('host_url(SCRIPT):      ' || apex_util.host_url('SCRIPT'));
    dbms_output.put_line('host_url(APEX_PATH):   ' || apex_util.host_url('APEX_PATH'));
    dbms_output.put_line('get_current_user_id:   ' || case when apex_util.get_current_user_id > 0 then '(ADMIN''s ID)' end);
    dbms_output.put_line('get_default_schema:    ' || apex_util.get_default_schema);
end;
/
