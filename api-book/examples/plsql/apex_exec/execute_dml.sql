-- @session app=200 page=1
-- @setup delete orb_promotions where promotion_id in (901, 902)
declare
    l_columns apex_exec.t_columns;
    l_context apex_exec.t_context;
begin
    apex_exec.add_column(l_columns, 'PROMOTION_ID',   apex_exec.c_data_type_number, p_is_primary_key => true);
    apex_exec.add_column(l_columns, 'PROMOTION_NAME', apex_exec.c_data_type_varchar2);
    apex_exec.add_column(l_columns, 'START_DATE',     apex_exec.c_data_type_date);
    apex_exec.add_column(l_columns, 'END_DATE',       apex_exec.c_data_type_date);
    apex_exec.add_column(l_columns, 'DISCOUNT_PCT',   apex_exec.c_data_type_number);
    apex_exec.add_column(l_columns, 'DESCRIPTION',    apex_exec.c_data_type_varchar2);

    l_context := apex_exec.open_local_dml_context(
                     p_columns    => l_columns,
                     p_query_type => apex_exec.c_query_type_table,
                     p_table_name => 'ORB_PROMOTIONS');

    for i in 1 .. 2 loop
        apex_exec.add_dml_row(l_context, apex_exec.c_dml_operation_insert);
        apex_exec.set_value(l_context, 'PROMOTION_ID',   900 + i);
        apex_exec.set_value(l_context, 'PROMOTION_NAME', 'API Lab Sale ' || i);
        apex_exec.set_value(l_context, 'START_DATE',     date '2026-06-01');
        apex_exec.set_value(l_context, 'END_DATE',       date '2026-06-30' - (i - 1) * 40);  -- row 2 ends before it starts
        apex_exec.set_value(l_context, 'DISCOUNT_PCT',   10 * i);
        apex_exec.set_null (l_context, 'DESCRIPTION');
    end loop;

    apex_exec.execute_dml(p_context => l_context, p_continue_on_error => true);

    for i in 1 .. 2 loop
        apex_exec.set_current_row(l_context, i);
        dbms_output.put_line('row ' || i || ': status ' || nvl(to_char(apex_exec.get_dml_status_code(l_context)), 'ok')
            || ' ' || regexp_replace(apex_exec.get_dml_status_message(l_context), 'ORA-\d+: '));
    end loop;
    dbms_output.put_line('has error: ' || case when apex_exec.has_error(l_context) then 'yes' else 'no' end);

    -- delete the row that was inserted: a new row set on the same context
    apex_exec.clear_dml_rows(l_context);
    apex_exec.add_dml_row(l_context, apex_exec.c_dml_operation_delete);
    apex_exec.set_value(l_context, 'PROMOTION_ID', 901);
    apex_exec.execute_dml(l_context);
    apex_exec.close(l_context);
end;
/
