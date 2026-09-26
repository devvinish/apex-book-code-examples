declare
    l_a apex_json.t_values;
    l_b apex_json.t_values;
begin
    -- Two documents parsed into local variables instead of apex_json.g_values
    apex_json.parse(p_values => l_a, p_source => '{"id": 1, "qtys": [5, 10, 20]}');
    apex_json.parse(p_values => l_b, p_source => '{"id": 2, "qtys": [7]}');

    dbms_output.put_line('a: id ' || apex_json.get_number(p_path => 'id', p_values => l_a)
        || ', qtys ' || apex_string.join(apex_json.get_t_number(p_path => 'qtys', p_values => l_a), '+'));
    dbms_output.put_line('b: id ' || apex_json.get_number(p_path => 'id', p_values => l_b));

    -- p_strict => false accepts unquoted member names and dangling commas
    apex_json.parse(p_values => l_a, p_source => '{name: "Tent", price: 249,}', p_strict => false);
    dbms_output.put_line('lax: ' || apex_json.get_varchar2(p_path => 'name', p_values => l_a));

    apex_json.parse(p_values => l_a, p_source => '{name: "Tent", price: 249,}');
exception
    when others then
        dbms_output.put_line('strict: ' || regexp_replace(sqlerrm, '^ORA-\d+: '));
end;
/
