-- @session app=200 page=1
declare
    l_pdf blob;
begin
    l_pdf := apex_print.generate_document(
                 p_data          => json_object('orderNumber' value 'ORD-10042',
                                                'lines' value json_array(json_object('sku' value 'TNT-1002', 'qty' value 2))),
                 p_template      => apex_util.clob_to_blob('Order {orderNumber}: {#lines}{sku} x {qty} {/lines}'),
                 p_template_type => apex_print.c_template_txt,
                 p_output_type   => apex_print.c_output_pdf);
    dbms_output.put_line(dbms_lob.getlength(l_pdf) || ' bytes');
exception when others then
    -- the lab's instance has no document generator configured
    dbms_output.put_line(regexp_replace(sqlerrm, 'ORA-\d+: '));
end;
/
