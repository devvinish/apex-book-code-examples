declare
    l_zip   blob;
    l_files apex_zip.t_files;
begin
    apex_zip.add_file(l_zip, 'a/one.txt', apex_util.clob_to_blob('1'));
    apex_zip.add_file(l_zip, 'b/two.txt', apex_util.clob_to_blob('2'));
    apex_zip.finish(l_zip);

    l_files := apex_zip.get_files(p_zipped_blob => l_zip);   -- deprecated: use get_dir_entries
    for i in 1 .. l_files.count loop
        dbms_output.put_line(i || ': ' || l_files(i));
    end loop;
end;
/
