declare
    l_paths apex_t_varchar2;
begin
    apex_json.parse('{"items":[{"sku":"TNT-2P","status":"SHIPPED"},'
                 || '{"sku":"BAG-0F","status":"BACKORDER"},'
                 || '{"sku":"LMP-HD","status":"SHIPPED"}]}');

    -- every element of items[] whose status member is SHIPPED
    l_paths := apex_json.find_paths_like(
                   p_return_path => 'items[%]',
                   p_subpath     => '.status',
                   p_value       => 'SHIPPED');
    for i in 1 .. l_paths.count loop
        dbms_output.put_line(l_paths(i) || ' -> ' || apex_json.get_varchar2(l_paths(i) || '.sku'));
    end loop;
end;
/
