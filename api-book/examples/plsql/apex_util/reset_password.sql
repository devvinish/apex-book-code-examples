begin
    apex_util.set_workspace(p_workspace => 'APEXBOOK');
    -- start clean: after RESET_PASSWORD, the user cannot be removed in the same database session
    for u in (select user_name from apex_workspace_apex_users
               where workspace_name = 'APEXBOOK' and user_name = 'ORBIT_RESET') loop
        apex_util.remove_user(p_user_id => apex_util.get_user_id(u.user_name));
    end loop;
    apex_util.create_user(p_user_name => 'ORBIT_RESET', p_web_password => 'Orbit#Demo2026',
                          p_email_address => 'reset.demo@orbit-outfitters.example');
    apex_util.reset_password(p_user_name => 'ORBIT_RESET', p_old_password => 'Orbit#Demo2026',
                             p_new_password => 'Orbit#Demo2027', p_change_password_on_first_use => true);
    dbms_output.put_line('new password valid: ' || case when apex_util.is_login_password_valid('ORBIT_RESET', 'Orbit#Demo2027') then 'yes' else 'no' end);
    dbms_output.put_line('old password valid: ' || case when apex_util.is_login_password_valid('ORBIT_RESET', 'Orbit#Demo2026') then 'yes' else 'no' end);
    dbms_output.put_line('must change it:     ' || case when apex_util.change_password_on_first_use('ORBIT_RESET') then 'yes' else 'no' end);
end;
/
