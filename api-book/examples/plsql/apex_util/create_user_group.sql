declare
    l_group_id number;
begin
    apex_util.set_workspace(p_workspace => 'APEXBOOK');     -- outside an application: see the text
    apex_util.create_user_group(p_group_name => 'ORBIT_BUYERS', p_group_desc => 'Orbit purchasing team');
    apex_util.create_user_group(p_group_name => 'ORBIT_STAFF');
    l_group_id := apex_util.get_group_id('ORBIT_BUYERS');
    dbms_output.put_line('group ' || apex_util.get_group_name(l_group_id) || ' has an ID: ' || case when l_group_id > 0 then 'yes' end);
    apex_util.create_user(p_user_name => 'ORBIT_DEMO', p_web_password => 'Orbit#Demo2026',
                          p_email_address => 'olivia.demo@orbit-outfitters.example');
    apex_util.set_group_user_grants(p_user_name => 'ORBIT_DEMO', p_granted_group_names => apex_t_varchar2('ORBIT_BUYERS'));
    apex_util.set_group_group_grants(p_group_name => 'ORBIT_BUYERS', p_granted_group_names => apex_t_varchar2('ORBIT_STAFF'));
    dbms_output.put_line('ORBIT_DEMO belongs to: ' || apex_util.get_groups_user_belongs_to('ORBIT_DEMO'));
    apex_util.remove_user(p_user_name => 'ORBIT_DEMO');
    apex_util.delete_user_group(p_group_name => 'ORBIT_BUYERS');
    apex_util.delete_user_group(p_group_id => apex_util.get_group_id('ORBIT_STAFF'));
    dbms_output.put_line('groups deleted');
end;
/
