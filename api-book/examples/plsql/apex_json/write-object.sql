begin
    apex_json.initialize_clob_output(p_indent => 2);   -- write to a CLOB, 2-space indents

    apex_json.open_object;                                  -- {
    apex_json.write('orderNumber', 'ORD-10042');
    apex_json.write('total',       1047.30);
    apex_json.write('orderDate',   date '2026-03-14');
    apex_json.write('paid',        true);
    apex_json.write('coupon',      cast(null as varchar2));  -- omitted
    apex_json.write('notes',       cast(null as varchar2), p_write_null => true);
    apex_json.write('tags',        apex_t_varchar2('priority', 'gift'));
    apex_json.open_object('customer');                      -- "customer": {
    apex_json.write('name', 'Alpine Outfitters');
    apex_json.close_object;                                 -- }
    apex_json.open_array('qtys');                           -- "qtys": [
    apex_json.write(2);
    apex_json.write(1);
    apex_json.close_array;                                  -- ]
    apex_json.close_all;                                    -- closes the root object

    dbms_output.put_line(apex_json.get_clob_output);
    apex_json.free_output;
end;
/
