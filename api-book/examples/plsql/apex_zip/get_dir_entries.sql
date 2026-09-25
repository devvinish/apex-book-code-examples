declare
    l_zip   blob;
    l_dir   apex_zip.t_dir_entries;
    l_name  varchar2(32767);
    l_file  blob;
begin
    apex_zip.add_file(l_zip, 'orders/2026-03.csv', apex_util.clob_to_blob('ORD-10042,1047.30'));
    apex_zip.add_file(l_zip, 'orders/2026-04.csv', apex_util.clob_to_blob('ORD-10077,249.00'));
    apex_zip.add_file(l_zip, 'README.txt',         apex_util.clob_to_blob('Monthly order files'));
    apex_zip.finish(l_zip);

    l_dir  := apex_zip.get_dir_entries(p_zipped_blob => l_zip);   -- indexed by file name
    l_name := l_dir.first;
    while l_name is not null loop
        l_file := apex_zip.get_file_content(p_zipped_blob => l_zip,
                                            p_dir_entry   => l_dir(l_name));
        dbms_output.put_line(rpad(l_name, 20) || lpad(l_dir(l_name).uncompressed_length, 3)
            || ' bytes: ' || utl_raw.cast_to_varchar2(dbms_lob.substr(l_file, 100, 1)));
        l_name := l_dir.next(l_name);
    end loop;

    -- deprecated signature 1: look a file up by name
    dbms_output.put_line('by name: ' || utl_raw.cast_to_varchar2(dbms_lob.substr(
        apex_zip.get_file_content(p_zipped_blob => l_zip, p_file_name => 'README.txt'), 100, 1)));
end;
/
