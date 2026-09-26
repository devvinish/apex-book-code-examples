declare
    l_csv  blob := apex_util.clob_to_blob('SKU,Price'       || chr(10) ||
                                          'TNT-2P,249.00'   || chr(10) ||
                                          'BAG-0F,389.50');
    l_rows pls_integer := 0;
begin
    for r in (select * from table(apex_data_parser.parse(l_csv, 'p.csv'))) loop
        l_rows := l_rows + 1;
    end loop;
    dbms_output.put_line(l_rows || ' rows parsed');
    -- the profile of the last parse() call, printed compactly
    dbms_output.put_line(json_object_t.parse(apex_data_parser.get_file_profile).to_clob);
end;
/
