declare
    l_page htp.htbuf_arr;
    l_rows integer := 999;
    l_name owa.vc_arr;
    l_val  owa.vc_arr;
    l_text varchar2(32767);
begin
    -- a browser request to the lab's login page, as ORDS sets it up
    l_name(1) := 'REQUEST_CHARSET'; l_val(1) := 'AL32UTF8';
    l_name(2) := 'SCRIPT_NAME';     l_val(2) := '/ords';
    l_name(3) := 'SERVER_NAME';     l_val(3) := 'localhost';
    l_name(4) := 'REQUEST_PROTOCOL'; l_val(4) := 'http';
    owa.init_cgi_env(4, l_name, l_val);
    htp.init;
    apex_session.create_session(p_app_id => 200, p_page_id => 9999, p_username => 'nobody');
    dbms_output.put_line('public user: ' || case when apex_authentication.is_public_user then 'yes' else 'no' end
                      || ', authenticated: ' || case when apex_authentication.is_authenticated then 'yes' else 'no' end);

    -- what the login page's process does: authenticate with the current scheme
    -- (the lab's "Open Door" accepts any password), then redirect to the home page
    apex_authentication.login(p_username => 'kim.lee', p_password => 'any password');

    dbms_output.put_line('user: ' || apex_application.g_user
                      || ', authenticated: ' || case when apex_authentication.is_authenticated then 'yes' else 'no' end);
    owa.get_page(l_page, l_rows);
    for i in 1 .. l_rows loop
        l_text := l_text || l_page(i);
    end loop;
    for h in (select column_value as line from table(apex_string.split(l_text, chr(10)))
               where regexp_like(column_value, '^(Set-Cookie|Location|Status)')) loop
        dbms_output.put_line(regexp_replace(regexp_replace(h.line, '=ORA_WWV-[^;]+', '=ORA_WWV-...'), 'session=\d+', 'session=...'));
    end loop;
end;
/
