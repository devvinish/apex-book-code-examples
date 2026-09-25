declare
    l_session_id number;
begin
    apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN');
    l_session_id := v('APP_SESSION');
    apex_util.set_session_state('P20_TEXT', 'kept in the session');
    apex_session.detach;                                  -- the session still exists
    dbms_output.put_line('detached: session ' || nvl(v('APP_SESSION'), '(none)'));

    apex_session.attach(p_app_id => 200, p_page_id => 20, p_session_id => l_session_id);
    dbms_output.put_line('attached again: P20_TEXT = ' || v('P20_TEXT'));
    apex_session.delete_session(p_session_id => l_session_id);
end;
/
