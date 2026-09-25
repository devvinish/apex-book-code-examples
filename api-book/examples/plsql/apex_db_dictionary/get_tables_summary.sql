begin
    dbms_output.put_line(apex_db_dictionary.get_tables_summary(p_regex => '^ORB_(STORES|WAREHOUSES|SUPPLIERS)$',
                                                                p_format => apex_db_dictionary.c_plain));
end;
/
