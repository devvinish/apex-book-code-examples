declare
    l_members apex_t_varchar2;
    l_value   apex_json.t_value;
begin
    apex_json.parse('{"sku":"TNT-2P","price":249,"active":true,"discontinued":false,'
                 || '"notes":null,"size":{"w":210,"h":130},"colors":["green","sand"]}');
    l_members := apex_json.get_members('.');   -- '.' is the root object
    for i in 1 .. l_members.count loop
        l_value := apex_json.get_value(l_members(i));
        dbms_output.put_line(rpad(l_members(i), 14) ||
            case apex_json.get_value_kind(l_members(i))
                when apex_json.c_null     then 'null'
                when apex_json.c_true     then 'true'
                when apex_json.c_false    then 'false'
                when apex_json.c_number   then 'number   ' || l_value.number_value
                when apex_json.c_varchar2 then 'varchar2 ' || l_value.varchar2_value
                when apex_json.c_object   then 'object   ' || apex_string.join(l_value.object_members, ',')
                when apex_json.c_array    then 'array    ' || apex_json.get_count(l_members(i)) || ' elements'
            end);
    end loop;
end;
/
