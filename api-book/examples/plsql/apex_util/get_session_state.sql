-- @session app=200 page=20 user=ADMIN
begin
    apex_util.set_session_state(p_name => 'P20_TEXT', p_value => 'Summit Daypack');
    apex_util.set_session_state('P20_NUMBER', '42.50');
    dbms_output.put_line('get_session_state: ' || apex_util.get_session_state('P20_TEXT'));
    dbms_output.put_line('v:                 ' || v('P20_TEXT'));
    dbms_output.put_line('get_numeric:       ' || apex_util.get_numeric_session_state('P20_NUMBER'));
    dbms_output.put_line('nv:                ' || nv('P20_NUMBER'));
    dbms_output.put_line('fetch_app_item:    ' || nvl(apex_util.fetch_app_item(p_item => 'G_SUPPORT_EMAIL'), '(null)'));
    apex_util.clear_page_cache(p_page_id => 20);          -- the page's items only
    dbms_output.put_line('after clear_page_cache: ' || nvl(v('P20_TEXT'), '(null)'));
    apex_util.set_session_state('P20_TEXT', 'again');
    apex_util.clear_app_cache(p_app_id => 200);             -- all items of the application
    dbms_output.put_line('after clear_app_cache:  ' || nvl(v('P20_TEXT'), '(null)'));
    apex_util.clear_user_cache;                            -- items and preferences of the session
end;
/
