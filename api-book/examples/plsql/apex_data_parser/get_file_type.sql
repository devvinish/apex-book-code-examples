begin
    for f in (select column_value as name
                from table(apex_t_varchar2('orders.xlsx', 'ORDERS.CSV', 'feed.json',
                                           'stores.xml', 'events.ics', 'notes.txt'))) loop
        dbms_output.put_line(rpad(f.name, 12) || ' type ' ||
            nvl(to_char(apex_data_parser.get_file_type(f.name)), '(null)') || ', is CSV: ' ||
            case when apex_data_parser.assert_file_type(f.name, apex_data_parser.c_file_type_csv)
                 then 'yes' else 'no' end);
    end loop;
end;
/
