-- @session app=200 page=1
declare
    l_filters apex_exec.t_filters;
    l_columns apex_exec.t_columns;
    l_context apex_exec.t_context;
    l_status  varchar2(30);
begin
    -- the lab's Duality View source "order-documents" (ORB_ORDER_DV); p_array_column_name
    -- returns a row per element of the LINES array, with the order's columns repeated
    apex_exec.add_filter(l_filters, apex_exec.c_filter_in, 'ID', apex_t_number(2, 3));
    l_context := apex_exec.open_query_context(
                     p_location               => apex_exec.c_location_duality_view,
                     p_duality_view_static_id => 'order-documents',
                     p_filters                => l_filters,
                     p_array_column_name      => 'LINES');
    while apex_exec.next_row(l_context) loop
        dbms_output.put_line(apex_exec.get_varchar2(l_context, 'ORDERNUMBER') || ' '
            || rpad(apex_exec.get_varchar2(l_context, 'STATUS'), 10) || ' line '
            || apex_exec.get_number(l_context, 'LINENO') || ': product '
            || apex_exec.get_number(l_context, 'PRODUCTID') || ' x '
            || apex_exec.get_number(l_context, 'QUANTITY'));
    end loop;
    apex_exec.close(l_context);

    -- change a document through the duality view
    apex_exec.add_column(l_columns, 'ID',     apex_exec.c_data_type_number, p_is_primary_key => true);
    apex_exec.add_column(l_columns, 'STATUS', apex_exec.c_data_type_varchar2);
    l_context := apex_exec.open_duality_view_dml_context(p_static_id => 'order-documents',
                                                         p_columns   => l_columns);
    apex_exec.add_dml_row(l_context, apex_exec.c_dml_operation_update);
    apex_exec.set_value(l_context, 'ID', 2);
    apex_exec.set_value(l_context, 'STATUS', 'SHIPPED');
    apex_exec.execute_dml(l_context);
    apex_exec.close(l_context);

    select json_value(data, '$.status') into l_status from orb_order_dv where json_value(data, '$._id') = 2;
    dbms_output.put_line('ORD-10002 now: ' || l_status);
    rollback;
end;
/
