declare
    l_in apex_json.t_values;
begin
    apex_json.parse(l_in, '{"order":{"no":"ORD-10042","items":[{"sku":"TNT-2P","qty":2},'
                       || '{"sku":"BAG-0F","qty":1}]},"audit":{"by":"SYNC"}}');

    apex_json.initialize_clob_output(p_indent => 1);
    apex_json.open_object;
    apex_json.write('source', 'webshop');
    apex_json.write('lines', l_in, 'order.items');          -- copy a parsed sub-tree
    apex_json.write('first', l_in, 'order.items[%d]', 1);   -- p0 fills %d
    apex_json.close_object;
    dbms_output.put_line(apex_json.get_clob_output(p_free => true));
end;
/
