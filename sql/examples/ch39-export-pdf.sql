-- Chapter 39: Export Top Customers PDF (page 7, Execute Code, Before Header, Request = EXPORT_PDF)
declare
    l_context apex_exec.t_context;
    l_columns apex_data_export.t_columns;
    l_export  apex_data_export.t_export;
begin
    l_context := apex_exec.open_query_context(
        p_location  => apex_exec.c_location_local_db,
        p_sql_query => q'[
            select c.customer_name    as customer,
                   c.customer_type    as customer_type,
                   c.city,
                   count(o.order_id)  as orders,
                   sum(o.order_total) as total_sales
              from orb_customers c
              join orb_orders o on o.customer_id = c.customer_id
             where o.status <> 'CANCELLED'
             group by c.customer_name, c.customer_type, c.city
             order by total_sales desc
             fetch first 25 rows only]');

    apex_data_export.add_column(p_columns => l_columns, p_name => 'CUSTOMER',      p_heading => 'Customer');
    apex_data_export.add_column(p_columns => l_columns, p_name => 'CUSTOMER_TYPE', p_heading => 'Type');
    apex_data_export.add_column(p_columns => l_columns, p_name => 'CITY',          p_heading => 'City');
    apex_data_export.add_column(p_columns => l_columns, p_name => 'ORDERS',        p_heading => 'Orders');
    apex_data_export.add_column(p_columns => l_columns, p_name => 'TOTAL_SALES',   p_heading => 'Total Sales',
                                p_format_mask => 'FML999G999G990D00');

    l_export := apex_data_export.export(
        p_context      => l_context,
        p_format       => apex_data_export.c_format_pdf,
        p_columns      => l_columns,
        p_file_name    => 'top_customers',
        p_print_config => apex_data_export.get_print_config(
            p_paper_size        => apex_data_export.c_size_letter,
            p_orientation       => apex_data_export.c_orientation_portrait,
            p_page_header       => 'Orbit Outfitters - Top 25 Customers',
            p_page_footer       => 'Printed ' || to_char(sysdate, 'DD-MON-YYYY'),
            p_header_bg_color   => '#8a4b2d',
            p_header_font_color => '#ffffff'));

    apex_exec.close(l_context);
    apex_data_export.download(p_export => l_export);
exception
    when others then
        apex_exec.close(l_context);
        raise;
end;
