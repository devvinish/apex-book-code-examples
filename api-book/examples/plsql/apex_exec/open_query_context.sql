-- @session app=200 page=1
declare
    l_filters  apex_exec.t_filters;
    l_order    apex_exec.t_order_bys;
    l_context  apex_exec.t_context;
    l_name_pos pls_integer;
begin
    -- filters and sort order are added to the query as APEX regions add theirs
    apex_exec.add_filter(p_filters => l_filters, p_filter_type => apex_exec.c_filter_starts_with,
                         p_column_name => 'SKU', p_value => 'TNT');
    apex_exec.add_filter(p_filters => l_filters, p_filter_type => apex_exec.c_filter_between,
                         p_column_name => 'UNIT_PRICE', p_from_value => 100, p_to_value => 300);
    apex_exec.add_order_by(p_order_bys => l_order, p_column_name => 'UNIT_PRICE',
                           p_direction => apex_exec.c_order_desc);

    l_context := apex_exec.open_query_context(
                     p_location        => apex_exec.c_location_local_db,
                     p_sql_query       => 'select sku, product_name, unit_price, launch_date from orb_products',
                     p_filters         => l_filters,
                     p_order_bys       => l_order,
                     p_max_rows        => 3,
                     p_total_row_count => true);

    dbms_output.put_line('total rows: ' || apex_exec.get_total_row_count(l_context));
    l_name_pos := apex_exec.get_column_position(l_context, 'PRODUCT_NAME');
    while apex_exec.next_row(l_context) loop
        dbms_output.put_line(apex_exec.get_varchar2(l_context, 'SKU') || '  '
            || rpad(apex_exec.get_varchar2(l_context, l_name_pos), 30)      -- by position
            || to_char(apex_exec.get_number(l_context, 'UNIT_PRICE'), '990.00') || '  '
            || to_char(apex_exec.get_date(l_context, 'LAUNCH_DATE'), 'DD-MON-YYYY'));
    end loop;
    apex_exec.close(l_context);
exception
    when others then
        apex_exec.close(l_context);   -- always close, also on errors
        raise;
end;
/
