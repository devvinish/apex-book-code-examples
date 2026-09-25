-- @session app=200 page=1
declare
    l_context apex_exec.t_context;
    l_export  apex_data_export.t_export;
begin
    -- create a real workbook from ORBIT data
    l_context := apex_exec.open_query_context(
                     p_location  => apex_exec.c_location_local_db,
                     p_sql_query => 'select sku, product_name, unit_price
                                       from orb_products order by product_id
                                      fetch first 3 rows only');
    l_export := apex_data_export.export(p_context => l_context,
                                        p_format  => apex_data_export.c_format_xlsx);
    apex_exec.close(l_context);

    for s in (select * from table(apex_data_parser.get_xlsx_worksheets(l_export.content_blob))) loop
        dbms_output.put_line('sheet ' || s.sheet_sequence || ': ' || s.sheet_display_name
                             || ' (' || s.sheet_file_name || ')');
    end loop;

    for r in (select line_number, col001, col002, col003
                from table(apex_data_parser.parse(
                         p_content         => l_export.content_blob,
                         p_file_name       => 'products.xlsx',
                         p_xlsx_sheet_name => 'sheet1.xml'))) loop
        dbms_output.put_line(r.line_number || ' | ' || r.col001 || ' | ' || r.col002 || ' | ' || r.col003);
    end loop;
end;
/
