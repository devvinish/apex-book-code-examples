-- @session app=200 page=1
declare
    l_context    apex_exec.t_context;
    l_columns    apex_data_export.t_columns;
    l_groups     apex_data_export.t_column_groups;
    l_aggregates apex_data_export.t_aggregates;
    l_highlights apex_data_export.t_highlights;
    l_export     apex_data_export.t_export;
    l_order_grp  pls_integer;
begin
    -- the query computes the values: break sums (per status) and the grand total,
    -- and a highlight flag, as an Interactive Report does
    l_context := apex_exec.open_query_context(
                     p_location  => apex_exec.c_location_local_db,
                     p_sql_query => q'~select status, order_number, order_total,
                                              sum(order_total) over (partition by status) as status_total,
                                              sum(order_total) over ()                    as grand_total,
                                              case when order_total > 1000 then 1 end      as big
                                         from orb_orders
                                        where order_id in (1, 2, 3, 4, 5, 6)
                                        order by status, order_number~');

    apex_data_export.add_column_group(p_column_groups => l_groups, p_idx => l_order_grp, p_name => 'Order');   -- returns the index
    apex_data_export.add_column(l_columns, p_name => 'STATUS', p_heading => 'Status', p_is_column_break => true);
    apex_data_export.add_column(l_columns, p_name => 'ORDER_NUMBER', p_heading => 'Number', p_column_group_idx => l_order_grp);
    apex_data_export.add_column(l_columns, p_name => 'ORDER_TOTAL',  p_heading => 'Total',  p_column_group_idx => l_order_grp,
                                p_format_mask => '999G990D00');

    apex_data_export.add_aggregate(p_aggregates => l_aggregates, p_label => 'Sum', p_format_mask => '999G990D00',
                                   p_display_column => 'ORDER_TOTAL', p_value_column => 'STATUS_TOTAL',
                                   p_overall_label => 'Total', p_overall_value_column => 'GRAND_TOTAL');
    apex_data_export.add_highlight(p_highlights => l_highlights, p_id => 1, p_value_column => 'BIG',
                                   p_display_column => 'ORDER_TOTAL', p_background_color => '#FFF3C4');

    l_export := apex_data_export.export(p_context => l_context, p_format => apex_data_export.c_format_pjson,
                                        p_columns => l_columns, p_column_groups => l_groups,
                                        p_aggregates => l_aggregates, p_highlights => l_highlights,
                                        p_as_clob => true);
    apex_exec.close(l_context);
    -- PJSON, the format APEX sends to a print server, shows the rows with their metadata
    dbms_output.put_line(json_object_t.parse(l_export.content_clob).get_array('rowset').to_clob);
end;
/
