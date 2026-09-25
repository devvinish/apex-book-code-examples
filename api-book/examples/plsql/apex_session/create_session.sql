begin
    apex_session.create_session(
        p_app_id   => 200,
        p_page_id  => 1,
        p_username => 'ADMIN');
    dbms_output.put_line('app ' || v('APP_ID') || ', page ' || v('APP_PAGE_ID')
        || ', user ' || v('APP_USER') || ', session ' || v('APP_SESSION'));
    -- the application's Initialization PL/SQL Code and computations ran:
    dbms_output.put_line('pending approvals: ' || v('G_PENDING_APPROVALS'));
    apex_session.delete_session;
    dbms_output.put_line('after delete_session: session ' || nvl(v('APP_SESSION'), '(none)'));
end;
/
