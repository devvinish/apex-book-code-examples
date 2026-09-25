-- @session app=200 page=1 user=KIM.LEE
declare
    l_cookie varchar2(200);
    l_path   varchar2(200);
    l_domain varchar2(200);
    l_secure boolean;
begin
    dbms_output.put_line('user:            ' || apex_custom_auth.get_username || ' / ' || apex_custom_auth.get_user);
    dbms_output.put_line('session:         ' || case when apex_custom_auth.get_session_id = v('APP_SESSION') then 'APP_SESSION' end);
    dbms_output.put_line('session exists:  ' || case when apex_custom_auth.session_id_exists then 'yes' else 'no' end);
    dbms_output.put_line('session valid:   ' || case when apex_custom_auth.is_session_valid then 'yes' else 'no' end);
    dbms_output.put_line('workspace:       ' || case when apex_custom_auth.get_security_group_id = v('WORKSPACE_ID')
                                                     then 'WORKSPACE_ID' end);
    dbms_output.put_line('next session ID: ' || case when apex_custom_auth.get_next_session_id > 0 then 'a new number' end);
    dbms_output.put_line('item P1_X:       ' || case when apex_custom_auth.application_page_item_exists('P1_X') then 'yes' else 'no' end);
    dbms_output.put_line('page public:     ' || case when apex_custom_auth.current_page_is_public then 'yes' else 'no' end);

    apex_custom_auth.get_cookie_props(p_app_id => 200, p_cookie_name => l_cookie, p_cookie_path => l_path,
                                      p_cookie_domain => l_domain, p_secure => l_secure);
    dbms_output.put_line('cookie:          ' || l_cookie || ', secure ' || case when l_secure then 'yes' else 'no' end);

    dbms_output.put_line('LDAP DN:         ' || apex_custom_auth.ldap_dnprep(p_username => 'kim.lee'));

    apex_custom_auth.set_user(p_user => 'KIM.LEE.ADMIN');       -- changes APP_USER of this session
    dbms_output.put_line('APP_USER now:    ' || v('APP_USER'));
end;
/
