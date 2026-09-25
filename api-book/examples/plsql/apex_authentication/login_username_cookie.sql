declare
    l_page htp.htbuf_arr;
    l_rows integer := 999;
    l_name owa.vc_arr;
    l_val  owa.vc_arr;
    l_text varchar2(32767);
begin
    -- a request that brings the cookie of an earlier login
    l_name(1) := 'REQUEST_CHARSET'; l_val(1) := 'AL32UTF8';
    l_name(2) := 'HTTP_COOKIE';     l_val(2) := 'LOGIN_USERNAME_COOKIE=kim.lee';
    l_name(3) := 'SCRIPT_NAME';     l_val(3) := '/ords';
    l_name(4) := 'SERVER_NAME';     l_val(4) := 'localhost';
    l_name(5) := 'REQUEST_PROTOCOL'; l_val(5) := 'http';
    l_name(6) := 'SERVER_PORT';     l_val(6) := '8080';
    l_name(7) := 'HTTP_HOST';       l_val(7) := 'localhost:8080';
    owa.init_cgi_env(7, l_name, l_val);
    htp.init;
    apex_session.create_session(p_app_id => 200, p_page_id => 9999, p_username => 'nobody');

    -- the login page's "Remember username": prefill the user name ...
    dbms_output.put_line('remembered: ' || apex_authentication.get_login_username_cookie);
    -- ... and store it again after a login (only with the user's consent)
    apex_authentication.send_login_username_cookie(p_username => 'kim.lee', p_consent => true);

    dbms_output.put_line('persistent auth:    ' || case when apex_authentication.persistent_auth_enabled then 'on' else 'off' end);
    dbms_output.put_line('persistent cookies: ' || case when apex_authentication.persistent_cookies_enabled then 'on' else 'off' end);
    dbms_output.put_line('callback: ' || regexp_replace(regexp_replace(apex_authentication.get_callback_url(p_x01 => 'orbit'),
                            'p_session_id=\d+', 'p_session_id=...'), 'p_ajax_identifier=[^&]+', 'p_ajax_identifier=...'));

    owa.get_page(l_page, l_rows);
    for i in 1 .. l_rows loop
        l_text := l_text || l_page(i);
    end loop;
    dbms_output.put_line(regexp_replace(regexp_substr(l_text, 'Set-Cookie:[^' || chr(10) || ']+'), 'expires=[^;]+', 'expires=(in 6 months)'));
end;
/
