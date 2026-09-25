-- @session app=200 page=1
declare
    l_columns apex_exec.t_columns;
    l_context apex_exec.t_context;
begin
    -- choose the columns, including one computed from the others
    apex_exec.add_column(p_columns => l_columns, p_column_name => 'SKU');
    apex_exec.add_column(p_columns => l_columns, p_column_name => 'UNIT_PRICE');
    apex_exec.add_column(p_columns => l_columns, p_column_name => 'COST_PRICE');
    apex_exec.add_column(p_columns => l_columns, p_column_name => 'MARGIN',
                         p_data_type => apex_exec.c_data_type_number,
                         p_sql_expression => 'unit_price - cost_price');
    l_context := apex_exec.open_query_context(
                     p_location  => apex_exec.c_location_local_db,
                     p_sql_query => q'~select * from orb_products where sku like 'KIT-100%' order by sku~',
                     p_columns   => l_columns,
                     p_max_rows  => 3);
    while apex_exec.next_row(l_context) loop
        dbms_output.put_line(apex_exec.get_varchar2(l_context, 1) || ' margin '
                          || apex_exec.get_number(l_context, 'MARGIN'));
    end loop;
    apex_exec.close(l_context);
end;
/
