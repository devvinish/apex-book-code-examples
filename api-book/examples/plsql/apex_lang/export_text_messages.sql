-- @session app=200 page=1
declare
    l_file clob;
    l_zip  blob;
    l_dir  apex_zip.t_dir_entries;
    l_name varchar2(4000);
begin
    -- one language as XLIFF (or CSV), for a translator
    l_file := apex_lang.export_text_messages(p_application_id => 200, p_lang_code => 'de',
                                             p_format => apex_lang.c_export_format_csv);
    dbms_output.put_line(dbms_lob.getlength(l_file) || ' characters of CSV, starting:');
    for r in (select column_value as line from table(apex_string.split(substr(l_file, 1, 400), chr(10)))
               fetch first 3 rows only) loop
        dbms_output.put_line('  ' || r.line);
    end loop;

    -- all languages: a ZIP file with a file per language
    l_zip := apex_lang.export_text_messages(p_application_id => 200, p_format => apex_lang.c_export_format_xliff);
    l_dir  := apex_zip.get_dir_entries(l_zip);
    l_name := l_dir.first;
    while l_name is not null loop
        dbms_output.put_line('in the ZIP: ' || l_name);
        l_name := l_dir.next(l_name);
    end loop;

    -- and back: the translated file updates (and adds) the messages
    apex_lang.import_text_messages(p_application_id => 200, p_file => l_file,
                                   p_format => apex_lang.c_export_format_csv);
    dbms_output.put_line('imported');
    rollback;
end;
/
