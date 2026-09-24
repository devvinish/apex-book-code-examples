begin
    dbms_network_acl_admin.append_host_ace(
        host       => 'smtp.orbit-outfitters.example',
        lower_port => 587,
        upper_port => 587,
        ace        => xs$ace_type(
                          privilege_list => xs$name_list('connect'),
                          principal_name => 'APEX_260100',
                          principal_type => xs_acl.ptype_db));
end;
