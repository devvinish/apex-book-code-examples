declare
    l_csv blob := apex_util.clob_to_blob('Path,Size' || chr(10) || '"C:\Temp\",12');
begin
    for flag in (select column_value as v from table(apex_t_varchar2('Y', 'N'))) loop
        apex_data_parser.set_parser_flags(p_name => 'CSV_BACKSLASH_ESCAPING', p_value => flag.v);
        for r in (select col001, col002
                    from table(apex_data_parser.parse(p_content => l_csv, p_file_name => 'x.csv',
                                                      p_skip_rows => 1))) loop
            dbms_output.put_line(flag.v || ': col001=[' || r.col001 || '] col002=[' || r.col002 || ']');
        end loop;
    end loop;
end;
/
