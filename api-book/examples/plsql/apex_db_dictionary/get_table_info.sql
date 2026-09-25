begin
    -- descriptions of tables for a language model (Markdown by default, or plain text)
    dbms_output.put_line('supported: ' || case when apex_db_dictionary.is_supported then 'yes' else 'no' end);
    dbms_output.put_line('tables: ' || apex_string.join(apex_db_dictionary.get_tables_array(p_regex => '^ORB_(ORDERS|CUSTOMERS)$'), ', '));
    dbms_output.put_line('primary key of ORB_ORDER_ITEMS: ' || apex_db_dictionary.get_primary_key_columns(p_table => 'ORB_ORDER_ITEMS'));
    dbms_output.put_line(apex_db_dictionary.get_table_info(p_table_names => 'ORB_CATEGORIES',
                                                            p_include_indexes => false));
end;
/
