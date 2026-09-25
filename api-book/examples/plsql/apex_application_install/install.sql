-- @setup begin apex_application_install.set_workspace('APEXBOOK'); apex_application_install.remove_application(9200); exception when others then null; end;
declare
    l_files apex_t_export_files;
    l_info  apex_application_install.t_file_info;
begin
    apex_util.set_workspace('APEXBOOK');
    l_files := apex_export.get_application(p_application_id => 200);

    -- what the file contains
    l_info := apex_application_install.get_info(p_source => l_files);
    dbms_output.put_line('file: application ' || l_info.app_id || ' "' || l_info.app_name || '", alias ' || l_info.app_alias
                         || ', workspace ' || l_info.workspace_name || ', APEX ' || l_info.version);

    -- install a copy with its own ID, alias, and name
    apex_application_install.clear_all;
    apex_application_install.set_workspace('APEXBOOK');
    apex_application_install.set_application_id(9200);
    apex_application_install.generate_offset;              -- new internal IDs for the copy
    apex_application_install.set_schema('ORBIT');
    apex_application_install.set_application_alias('API-LAB-COPY');
    apex_application_install.set_application_name('API Lab (copy)');
    apex_application_install.set_build_status('RUN_ONLY');
    apex_application_install.set_auto_install_sup_obj(p_auto_install_sup_obj => false);
    dbms_output.put_line('install as: ' || apex_application_install.get_application_id || ', '
                         || apex_application_install.get_application_alias || ', '
                         || apex_application_install.get_application_name || ', schema '
                         || apex_application_install.get_schema || ', ' || apex_application_install.get_build_status);
    apex_application_install.install(p_source => l_files);

    for a in (select application_id, application_name, alias, build_status, pages
                from apex_applications where application_id = 9200) loop
        dbms_output.put_line('installed:  ' || a.application_id || ' "' || a.application_name || '", '
                             || a.alias || ', ' || a.build_status || ', ' || a.pages || ' pages');
    end loop;

    apex_application_install.remove_application(p_application_id => 9200);
    dbms_output.put_line('removed');
end;
/
