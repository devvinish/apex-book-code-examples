declare
    l_id number;
begin
    apex_util.set_workspace(p_workspace => 'APEXBOOK');     -- outside an application: see the text
    apex_util.create_user(
        p_user_name                    => 'ORBIT_DEMO',
        p_first_name                   => 'Olivia',
        p_last_name                    => 'Demo',
        p_email_address                => 'olivia.demo@orbit-outfitters.example',
        p_web_password                 => 'Orbit#Demo2026',
        p_change_password_on_first_use => 'N',
        p_attribute_01                 => 'STORE-7');
    l_id := apex_util.get_user_id('ORBIT_DEMO');
    dbms_output.put_line('user:  ' || apex_util.get_username(l_id) || ' - ' || apex_util.get_first_name('ORBIT_DEMO')
        || ' ' || apex_util.get_last_name('ORBIT_DEMO') || ' <' || apex_util.get_email('ORBIT_DEMO') || '>');
    dbms_output.put_line('attr1: ' || apex_util.get_attribute('ORBIT_DEMO', 1) || ', roles: ' || nvl(apex_util.get_user_roles('ORBIT_DEMO'), '(end user)'));
    apex_util.set_email(l_id, 'o.demo@orbit-outfitters.example');       -- the setters take the user ID
    apex_util.set_first_name(l_id, 'Liv');
    apex_util.set_last_name(l_id, 'Demo-Smith');
    apex_util.set_attribute(l_id, 2, 'EU');
    apex_util.set_username(l_id, 'ORBIT_DEMO2');
    dbms_output.put_line('now:   ' || apex_util.get_username(l_id) || ' - ' || apex_util.get_first_name('ORBIT_DEMO2')
        || ' ' || apex_util.get_last_name('ORBIT_DEMO2') || ' <' || apex_util.get_email('ORBIT_DEMO2') || '>, attr2 '
        || apex_util.get_attribute('ORBIT_DEMO2', 2));
    dbms_output.put_line('unique ORBIT_DEMO2: ' || case when apex_util.is_username_unique('ORBIT_DEMO2') then 'yes' else 'no, taken' end);
    apex_util.remove_user(p_user_name => 'ORBIT_DEMO2');
    dbms_output.put_line('removed: ' || case when apex_util.is_username_unique('ORBIT_DEMO2') then 'yes' end);
end;
/
