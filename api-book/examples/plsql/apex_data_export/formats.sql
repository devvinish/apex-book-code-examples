-- @session app=200 page=1
declare
    l_context apex_exec.t_context;
    l_export  apex_data_export.t_export;
begin
    for f in (select column_value as format
                from table(apex_t_varchar2('CSV', 'HTML', 'JSON', 'PJSON', 'XML', 'PXML', 'XLSX', 'PDF'))) loop
        l_context := apex_exec.open_query_context(
                         p_location  => apex_exec.c_location_local_db,
                         p_sql_query => 'select sku, unit_price from orb_products fetch first 2 rows only');
        begin
            l_export := apex_data_export.export(p_context => l_context, p_format => f.format);
            dbms_output.put_line(rpad(f.format, 6) || rpad(l_export.file_name, 12) || rpad(l_export.mime_type, 66)
                || dbms_lob.getlength(l_export.content_blob) || ' bytes');
        exception when others then
            dbms_output.put_line(rpad(f.format, 6) || regexp_replace(sqlerrm, 'ORA-\d+: '));
        end;
        apex_exec.close(l_context);
    end loop;
end;
/
