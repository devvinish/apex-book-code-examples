-- @session app=200 page=1
declare
    l_context apex_exec.t_context;
    l_columns apex_data_export.t_columns;
    l_export  apex_data_export.t_export;
begin
    l_context := apex_exec.open_query_context(
                     p_location  => apex_exec.c_location_local_db,
                     p_sql_query => q'~select sku, product_name, unit_price, launch_date
                                         from orb_products where sku like 'TNT-100%' order by sku
                                        fetch first 3 rows only~');

    -- which columns, with headings and format masks
    apex_data_export.add_column(p_columns => l_columns, p_name => 'SKU');
    apex_data_export.add_column(p_columns => l_columns, p_name => 'PRODUCT_NAME', p_heading => 'Product');
    apex_data_export.add_column(p_columns => l_columns, p_name => 'UNIT_PRICE',   p_heading => 'Price',
                                p_format_mask => 'FML999G990D00');

    l_export := apex_data_export.export(p_context   => l_context,
                                        p_format    => apex_data_export.c_format_csv,
                                        p_columns   => l_columns,
                                        p_file_name => 'tents',
                                        p_as_clob   => true);
    apex_exec.close(l_context);

    dbms_output.put_line(l_export.file_name || ' - ' || l_export.mime_type || ' - ' || l_export.row_count || ' rows');
    dbms_output.put_line(l_export.content_clob);
end;
/
