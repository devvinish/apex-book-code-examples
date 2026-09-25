-- @session app=200 page=1
declare
    l_context apex_exec.t_context;
    l_config  apex_data_export.t_print_config;
    l_export  apex_data_export.t_export;
begin
    l_config := apex_data_export.get_print_config(
                    p_orientation           => apex_data_export.c_orientation_landscape,
                    p_paper_size            => apex_data_export.c_size_a4,
                    p_page_header           => 'ORBIT Outfitters - Tents',
                    p_header_bg_color       => '#1F3A5F',
                    p_header_font_color     => '#FFFFFF',
                    p_header_font_weight    => apex_data_export.c_font_weight_bold,
                    p_body_font_family      => apex_data_export.c_font_family_courier);

    l_context := apex_exec.open_query_context(
                     p_location  => apex_exec.c_location_local_db,
                     p_sql_query => q'~select sku, product_name from orb_products where sku like 'TNT%'~');
    l_export := apex_data_export.export(p_context => l_context, p_format => apex_data_export.c_format_pjson,
                                        p_print_config => l_config, p_as_clob => true);
    apex_exec.close(l_context);

    -- the settings a PDF export (or a print server) uses
    dbms_output.put_line(json_object_t.parse(l_export.content_clob).get_object('printConfig').to_clob);
end;
/
