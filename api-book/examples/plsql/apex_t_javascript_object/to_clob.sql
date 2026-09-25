declare
    l_obj apex_t_javascript_object := apex_t_javascript_object();
begin
    l_obj.open_object;
    l_obj.put('orderNumber', 'ORD-12283');
    l_obj.put('total', 463.21);
    l_obj.put('shipped', true);
    l_obj.put('note', cast(null as varchar2));             -- omitted by default
    l_obj.put_function('onShip', 'apex.message.showPageSuccess("Shipped")', apex_javascript.c_type_function_body);
    l_obj.put_raw('created', 'new Date(2026, 8, 23)');
    l_obj.open_array('lines');
    l_obj.append('Tent'); l_obj.append(2);
    l_obj.append_function('return 1 + 1', apex_javascript.c_type_function_body);
    l_obj.close_array;
    l_obj.close_object;
    dbms_output.put_line(l_obj.to_clob);
    l_obj.reset;
    dbms_output.put_line('after reset, is_null: ' || case when l_obj.is_null then 'yes' else 'no' end);
end;
/
