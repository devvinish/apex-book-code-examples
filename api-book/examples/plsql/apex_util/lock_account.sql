declare
    procedure yn(p_label varchar2, p_value boolean) is
    begin
        dbms_output.put_line(rpad(p_label, 34) || case when p_value then 'TRUE' else 'FALSE' end);
    end;
begin
    apex_util.set_workspace(p_workspace => 'APEXBOOK');     -- outside an application: see the text
    apex_util.create_user(p_user_name => 'ORBIT_DEMO', p_web_password => 'Orbit#Demo2026',
                          p_email_address => 'olivia.demo@orbit-outfitters.example', p_change_password_on_first_use => 'N');
    apex_util.lock_account('ORBIT_DEMO');
    yn('locked:', apex_util.get_account_locked_status('ORBIT_DEMO'));
    apex_util.unlock_account('ORBIT_DEMO');
    yn('after unlock_account:', apex_util.get_account_locked_status('ORBIT_DEMO'));
    dbms_output.put_line(rpad('end_user_account_days_left:', 34) || nvl(to_char(apex_util.end_user_account_days_left('ORBIT_DEMO')), '(no expiry)'));
    apex_util.expire_end_user_account('ORBIT_DEMO');
    dbms_output.put_line(rpad('after expire_end_user_account:', 34) || apex_util.end_user_account_days_left('ORBIT_DEMO'));
    apex_util.unexpire_end_user_account('ORBIT_DEMO');
    dbms_output.put_line(rpad('after unexpire_end_user_account:', 34) || nvl(to_char(apex_util.end_user_account_days_left('ORBIT_DEMO')), '(no expiry)'));
    dbms_output.put_line(rpad('workspace_account_days_left:', 34) || nvl(to_char(apex_util.workspace_account_days_left('ORBIT_DEMO')), '(null)'));
    apex_util.expire_workspace_account('ORBIT_DEMO');
    apex_util.unexpire_workspace_account('ORBIT_DEMO');
    yn('change_password_on_first_use:', apex_util.change_password_on_first_use('ORBIT_DEMO'));
    yn('password_first_use_occurred:', apex_util.password_first_use_occurred('ORBIT_DEMO'));
    yn('is_login_password_valid:', apex_util.is_login_password_valid('ORBIT_DEMO', 'Orbit#Demo2026'));
end;
/
begin
    apex_util.set_workspace(p_workspace => 'APEXBOOK');
    apex_util.remove_user(p_user_id => apex_util.get_user_id('ORBIT_DEMO'));
end;
/
