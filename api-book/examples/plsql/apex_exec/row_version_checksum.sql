-- @session app=200 page=1
declare
    l_columns  apex_exec.t_columns;
    l_query    apex_exec.t_context;
    l_dml      apex_exec.t_context;
    l_checksum varchar2(4000);
begin
    apex_exec.add_column(l_columns, 'PROMOTION_ID',  apex_exec.c_data_type_number, p_is_primary_key => true);
    apex_exec.add_column(l_columns, 'DISCOUNT_PCT',  apex_exec.c_data_type_number);

    -- read the row and keep its checksum, as a form does when it loads
    l_query := apex_exec.open_query_context(
                   p_location => apex_exec.c_location_local_db, p_table_name => 'ORB_PROMOTIONS',
                   p_where_clause => 'promotion_id = 1', p_columns => l_columns);
    if apex_exec.next_row(l_query) then
        l_checksum := apex_exec.get_row_version_checksum(l_query);
        dbms_output.put_line('read: ' || apex_exec.get_number(l_query, 'DISCOUNT_PCT') || '% - checksum ' || substr(l_checksum, 1, 12) || '...');
    end if;
    apex_exec.close(l_query);

    update orb_promotions set discount_pct = discount_pct + 1 where promotion_id = 1;   -- someone else

    l_dml := apex_exec.open_local_dml_context(
                 p_columns => l_columns, p_query_type => apex_exec.c_query_type_table,
                 p_table_name => 'ORB_PROMOTIONS', p_lost_update_detection => apex_exec.c_lost_update_implicit);
    apex_exec.add_dml_row(l_dml, apex_exec.c_dml_operation_update);
    apex_exec.set_value(l_dml, 'PROMOTION_ID', 1);
    apex_exec.set_value(l_dml, 'DISCOUNT_PCT', 50);
    apex_exec.set_row_version_checksum(l_dml, l_checksum);   -- the checksum read before
    begin
        apex_exec.execute_dml(l_dml);
    exception when others then
        dbms_output.put_line('update: ' || regexp_replace(sqlerrm, 'ORA-\d+: '));
    end;
    apex_exec.close(l_dml);
    rollback;
end;
/
