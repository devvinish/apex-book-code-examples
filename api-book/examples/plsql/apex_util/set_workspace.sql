declare
    l_sgid number;
begin
    apex_util.set_workspace(p_workspace => 'APEXBOOK');   -- outside an APEX session
    l_sgid := apex_util.find_security_group_id(p_workspace => 'APEXBOOK');
    dbms_output.put_line('security group ID found: ' || case when l_sgid > 0 then 'yes' end);
    dbms_output.put_line('find_workspace:          ' || apex_util.find_workspace(p_security_group_id => l_sgid));
    apex_util.set_security_group_id(p_security_group_id => l_sgid);   -- the same, by ID
    dbms_output.put_line('get_apex_owner:          ' || apex_util.get_apex_owner);
    dbms_output.put_line('get_default_schema:      ' || nvl(apex_util.get_default_schema, '(null: no APEX user)'));
    dbms_output.put_line('get_edition:             ' || nvl(apex_util.get_edition, '(null)'));
    apex_util.close_open_db_links;
end;
/
