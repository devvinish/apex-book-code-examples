-- @connect sysdba
begin
    -- instance settings (the Administration Services pages), for a user with APEX_ADMINISTRATOR_ROLE
    for p in (select column_value as name from table(apex_t_varchar2(
                  'SMTP_HOST_ADDRESS', 'SMTP_HOST_PORT', 'MAX_SESSION_LENGTH_SEC', 'ACCOUNT_LIFETIME_DAYS',
                  'ALLOW_PUBLIC_FILE_UPLOAD', 'WORKSPACE_PROVISION_DEMO_OBJECTS'))) loop
        dbms_output.put_line(rpad(p.name, 33) || nvl(apex_instance_admin.get_parameter(p.name), '(null)'));
    end loop;

    dbms_output.put_line('schemas of APEXBOOK: ' || apex_instance_admin.get_schemas(p_workspace => 'APEXBOOK'));
    dbms_output.put_line('MAX_SESSION_IDLE_SEC of APEXBOOK: '
        || nvl(apex_instance_admin.get_workspace_parameter(p_workspace => 'APEXBOOK', p_parameter => 'MAX_SESSION_IDLE_SEC'), '(instance default)'));
    dbms_output.put_line('database signature valid: '
        || case when apex_instance_admin.is_db_signature_valid then 'yes' else 'no' end);
end;
/
