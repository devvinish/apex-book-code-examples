begin
    apex_util.set_workspace('APEXBOOK');
    dbms_output.put_line('name:    ' || apex_application_admin.get_application_name(200)
                         || ', alias ' || apex_application_admin.get_application_alias(200)
                         || ', version ' || apex_application_admin.get_application_version(200));
    dbms_output.put_line('schema:  ' || apex_application_admin.get_parsing_schema(200)
                         || ', build ' || apex_application_admin.get_build_status(200)
                         || ', auth ' || apex_application_admin.get_authentication_scheme(200));
    dbms_output.put_line('status:  ' || apex_application_admin.get_application_status(200));

    -- take the application offline for maintenance: only ADMIN may still use it
    apex_application_admin.set_application_status(
        p_application_id     => 200,
        p_application_status => 'RESTRICTED_ACCESS',
        p_allowed_users_list => apex_t_varchar2('ADMIN'),
        p_message            => 'The API Lab is being updated. Back at 14:00.');
    apex_application_admin.set_global_notification(200, 'Maintenance today from 13:00 to 14:00.');
    dbms_output.put_line('now:     ' || apex_application_admin.get_application_status(200)
                         || ' - ' || apex_application_admin.get_global_notification(200));

    apex_application_admin.set_application_status(p_application_id => 200, p_application_status => 'AVAILABLE_W_EDIT_LINK');
    apex_application_admin.set_global_notification(200, null);
    apex_application_admin.set_application_version(200, apex_application_admin.get_application_version(200));
    dbms_output.put_line('back to: ' || apex_application_admin.get_application_status(200));
end;
/
