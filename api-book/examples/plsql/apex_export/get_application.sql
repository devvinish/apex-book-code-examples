declare
    l_files apex_t_export_files;
    l_zip   blob;
    procedure show(p_label varchar2) is
        l_chars number := 0;
    begin
        for i in 1 .. l_files.count loop
            l_chars := l_chars + nvl(dbms_lob.getlength(l_files(i).contents), 0);
        end loop;
        dbms_output.put_line(rpad(p_label, 16) || lpad(l_files.count, 4) || ' file(s), ' || lpad(l_chars, 8)
                             || ' chars, first: ' || l_files(1).name);
    end;
begin
    apex_util.set_workspace('APEXBOOK');      -- outside APEX: the workspace of the application

    l_files := apex_export.get_application(p_application_id => 200);
    show('SQL');
    l_files := apex_export.get_application(p_application_id => 200, p_split => true);
    show('SQL, split');
    l_files := apex_export.get_application(p_application_id => 200, p_type => apex_export.c_type_readable_yaml);
    show('readable YAML');
    l_files := apex_export.get_application(p_application_id => 200, p_type => apex_export.c_type_apexlang);
    show('APEXlang');
    l_files := apex_export.get_application(p_application_id => 200, p_split => true,
                                           p_components => apex_t_varchar2('PAGE:8', 'LOV:%'));
    show('page 8 and LOVs');
    l_files := apex_export.get_application(p_application_id => 200, p_type => apex_export.c_type_checksum_sh256);
    dbms_output.put_line('checksum: ' || substr(l_files(1).contents, 1, 20) || '...');

    -- all files in one ZIP, and back
    l_files := apex_export.get_application(p_application_id => 200, p_split => true);
    l_zip   := apex_export.zip(p_source_files => l_files);
    dbms_output.put_line('ZIP: ' || round(dbms_lob.getlength(l_zip) / 1024) || ' KB, unzipped: '
                         || apex_export.unzip(p_source_zip => l_zip).count || ' files');
end;
/
