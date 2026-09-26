-- @session app=200 page=2 user=ADMIN
declare
    l_export apex_data_export.t_export;
begin
    l_export := apex_region.export_data(
        p_format    => apex_data_export.c_format_csv,
        p_page_id   => 2,
        p_region_id => apex_region.get_id(p_page_id => 2, p_dom_static_id => 'customers'),
        p_max_rows  => 3,
        p_as_clob   => true);
    dbms_output.put_line(l_export.file_name || ' (' || l_export.mime_type || ')');
    for r in (select column_value as line from apex_string.split(substr(l_export.content_clob, 1, 1000), chr(10)) where rownum <= 3) loop
        dbms_output.put_line(substr(r.line, 1, 90) || case when length(r.line) > 90 then '...' end);
    end loop;
end;
/
