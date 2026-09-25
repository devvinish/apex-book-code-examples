-- @setup begin apex_util.set_workspace('APEXBOOK'); apex_acl.remove_all_user_roles(p_application_id => 200, p_user_name => 'KIM.LEE'); end;
declare
    l_role_id number;
    procedure show(p_label varchar2) is
        l_roles varchar2(400);
    begin
        select listagg(role_static_id, ', ') within group (order by role_static_id) into l_roles
          from apex_appl_acl_user_roles where application_id = 200 and user_name = 'KIM.LEE';
        dbms_output.put_line(rpad(p_label, 14) || nvl(l_roles, '-'));
    end;
begin
    -- outside an APEX session: set the workspace
    apex_util.set_workspace('APEXBOOK');

    apex_acl.add_user_role(p_application_id => 200, p_user_name => 'kim.lee', p_role_static_id => 'READER');
    select role_id into l_role_id from apex_appl_acl_roles
     where application_id = 200 and role_static_id = 'approver';
    apex_acl.add_user_role(p_application_id => 200, p_user_name => 'KIM.LEE', p_role_id => l_role_id);
    show('added');

    dbms_output.put_line('any role:     ' || case when apex_acl.has_user_any_roles(p_application_id => 200,
        p_user_name => 'KIM.LEE') then 'yes' else 'no' end);
    dbms_output.put_line('READER:       ' || case when apex_acl.has_user_role(p_application_id => 200,
        p_user_name => 'KIM.LEE', p_role_static_id => 'READER') then 'yes' else 'no' end);
    dbms_output.put_line('approver:     ' || case when apex_acl.has_user_role(p_application_id => 200,
        p_user_name => 'KIM.LEE', p_role_static_id => 'approver') then 'yes' else 'no' end);

    -- replace all roles with this list (static IDs or role IDs)
    apex_acl.replace_user_roles(p_application_id => 200, p_user_name => 'KIM.LEE',
                                p_role_static_ids => apex_t_varchar2('CONTRIBUTOR', 'READER'));
    show('replaced');

    -- would setting ADMIN's roles to just READER take ADMINISTRATOR away?
    select role_id into l_role_id from apex_appl_acl_roles
     where application_id = 200 and role_static_id = 'READER';
    dbms_output.put_line('removes admin: ' || case when apex_acl.is_role_removed_from_user(p_application_id => 200,
        p_user_name => 'ADMIN', p_role_static_id => 'ADMINISTRATOR', p_role_ids => apex_t_number(l_role_id))
        then 'yes' else 'no' end);

    apex_acl.remove_user_role(p_application_id => 200, p_user_name => 'KIM.LEE', p_role_static_id => 'READER');
    show('removed');
    apex_acl.remove_all_user_roles(p_application_id => 200, p_user_name => 'KIM.LEE');
    show('all removed');
end;
/
