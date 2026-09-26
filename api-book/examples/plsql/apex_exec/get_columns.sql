-- @session app=200 page=1
declare
    l_context apex_exec.t_context;
    l_columns apex_exec.t_columns;
    l_column  apex_exec.t_column;
begin
    l_context := apex_exec.open_query_context(
                     p_location  => apex_exec.c_location_local_db,
                     p_sql_query => 'select id, store_name, opened_on, flagship, latitude from orb_stores',
                     p_max_rows  => 0);                                    -- no rows, just the columns
    dbms_output.put_line('columns: ' || apex_exec.get_column_count(l_context));
    for i in 1 .. apex_exec.get_column_count(l_context) loop
        l_column := apex_exec.get_column(l_context, i);
        dbms_output.put_line(i || ' ' || rpad(l_column.name, 11)
            || apex_exec.get_data_type(l_column.data_type) || ' (' || l_column.data_type || ')');
    end loop;
    apex_exec.close(l_context);

    dbms_output.put_line('type code of NUMBER: ' || apex_exec.get_data_type('NUMBER'));

    -- describe a query without running it
    l_columns := apex_exec.describe_query(
                     p_location  => apex_exec.c_location_local_db,
                     p_sql_query => 'select order_id, order_total, order_date from orb_orders');
    for i in 1 .. l_columns.count loop
        dbms_output.put_line('described: ' || l_columns(i).name || ' ' ||
                             apex_exec.get_data_type(l_columns(i).data_type));
    end loop;
    dbms_output.put_line('has ORDER_DATE: ' ||
        case when apex_exec.column_exists(l_columns, 'ORDER_DATE') then 'yes' else 'no' end);
end;
/
