-- @session app=200 page=1
declare
    l_context apex_exec.t_context;
    l_export  apex_data_export.t_export;
    l_page    htp.htbuf_arr;
    l_rows    integer := 999;
    l_name    owa.vc_arr;
    l_val     owa.vc_arr;
begin
    l_name(1) := 'REQUEST_CHARSET'; l_val(1) := 'AL32UTF8';     -- a web request, as ORDS sets it up
    owa.init_cgi_env(1, l_name, l_val);
    htp.init;

    l_context := apex_exec.open_query_context(
                     p_location  => apex_exec.c_location_local_db,
                     p_sql_query => 'select sku, unit_price from orb_products fetch first 2 rows only');
    l_export := apex_data_export.export(p_context => l_context, p_format => apex_data_export.c_format_csv,
                                        p_file_name => 'prices');
    apex_exec.close(l_context);

    -- in a page process, leave p_stop_apex_engine at its default (true)
    apex_data_export.download(p_export => l_export, p_stop_apex_engine => false);

    owa.get_page(l_page, l_rows);                 -- what the browser receives
    for i in 1 .. l_rows loop
        dbms_output.put(l_page(i));
    end loop;
    dbms_output.new_line;
end;
/
