declare
    l_email varchar2(240); l_first varchar2(255); l_last varchar2(255); l_roles varchar2(4000);
    l_workspace varchar2(255); l_web_pw varchar2(255); l_desc varchar2(240);
    l_groups varchar2(4000); l_schemas varchar2(4000);
begin
    apex_util.set_workspace(p_workspace => 'APEXBOOK');     -- outside an application: see the text
    apex_util.create_user(p_user_name => 'ORBIT_DEMO', p_email_address => 'olivia.demo@orbit-outfitters.example',
                          p_web_password => 'Orbit#Demo2026', p_first_name => 'Olivia');
    apex_util.fetch_user(
        p_user_id => apex_util.get_user_id('ORBIT_DEMO'),
        p_workspace => l_workspace, p_user_name => l_desc, p_first_name => l_first, p_last_name => l_last,
        p_web_password => l_web_pw, p_email_address => l_email, p_start_date => l_desc, p_end_date => l_desc,
        p_employee_id => l_desc, p_allow_access_to_schemas => l_schemas, p_person_type => l_desc,
        p_default_schema => l_desc, p_groups => l_groups, p_developer_role => l_roles, p_description => l_desc);
    dbms_output.put_line('workspace ' || l_workspace || ', ' || l_first || ' <' || l_email || '>, roles ' || nvl(l_roles, '(none)'));
    apex_util.edit_user(p_user_id => apex_util.get_user_id('ORBIT_DEMO'), p_user_name => 'ORBIT_DEMO',
                        p_first_name => 'Olivia', p_last_name => 'Demo', p_email_address => l_email,
                        p_developer_roles => 'CREATE:EDIT');       -- make a developer
    dbms_output.put_line('roles after edit_user: ' || apex_util.get_user_roles('ORBIT_DEMO'));
    apex_util.remove_user(p_user_name => 'ORBIT_DEMO');
end;
/
