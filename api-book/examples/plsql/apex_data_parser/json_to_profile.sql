declare
    l_profile apex_data_parser.t_file_profile;
begin
    l_profile := apex_data_parser.json_to_profile(apex_data_parser.discover(
                     p_content   => apex_util.clob_to_blob('A|B|C' || chr(10) || '1|x|2026-01-31'),
                     p_file_name => 'pipes.csv'));
    dbms_output.put_line('file type:  ' || l_profile.file_type);
    dbms_output.put_line('delimiter:  ' || l_profile.csv_delimiter);
    dbms_output.put_line('headings:   ' || case when l_profile.first_row_headings then 'yes' else 'no' end);
    dbms_output.put_line('columns:    ' || l_profile.file_columns.count);
    for i in 1 .. l_profile.file_columns.count loop
        dbms_output.put_line('  ' || l_profile.file_columns(i).name || ' data type ' || l_profile.file_columns(i).data_type
                             || ' ' || l_profile.file_columns(i).format_mask);
    end loop;
end;
/
