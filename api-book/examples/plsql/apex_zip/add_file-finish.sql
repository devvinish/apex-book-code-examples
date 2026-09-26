declare
    l_zip blob;
begin
    -- one CSV per top-level category, plus a README in the root
    for c in (select category_id, category_name
                from orb_categories
               where parent_category_id is null and category_id <= 3
               order by category_id) loop
        apex_zip.add_file(
            p_zipped_blob => l_zip,
            p_file_name   => 'categories/' || lower(c.category_name) || '.csv',
            p_content     => apex_util.clob_to_blob(
                               'category_id,category_name' || chr(10) ||
                               c.category_id || ',' || c.category_name));
    end loop;
    apex_zip.add_file(l_zip, 'README.txt', apex_util.clob_to_blob('Exported from ORBIT'));
    apex_zip.finish(p_zipped_blob => l_zip);   -- writes the central directory

    dbms_output.put_line('zip size: ' || dbms_lob.getlength(l_zip) || ' bytes');
    dbms_output.put_line('signature: ' || utl_raw.cast_to_varchar2(dbms_lob.substr(l_zip, 2, 1)));
end;
/
