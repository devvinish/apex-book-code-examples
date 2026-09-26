-- @session app=200 page=20
declare
    l_lov  varchar2(400) := 'select product_name as d, product_id as r from orb_products order by 1';
    l_data apex_plugin_util.t_column_value_list;
    l_cols apex_plugin_util.t_column_list;
    l_list dbms_sql.varchar2a;
    l_find dbms_sql.varchar2a;
begin
    -- the LOV query of a plug-in: rows whose display column contains "tent", at most 3
    l_data := apex_plugin_util.get_data(
                  p_sql_statement      => l_lov,
                  p_min_columns        => 2,
                  p_max_columns        => 2,
                  p_component_name     => 'P20_PRODUCT',
                  p_search_type        => apex_plugin_util.c_search_contains_ignore,
                  p_search_column_name => 'D',
                  p_search_string      => apex_plugin_util.get_search_string(   -- prepared for the
                                              apex_plugin_util.c_search_contains_ignore, 'tent'),  -- search type
                  p_max_rows           => 3);
    for i in 1 .. l_data(1).count loop          -- one array per column
        dbms_output.put_line(l_data(2)(i) || ' = ' || l_data(1)(i));
    end loop;

    -- get_data2: typed values, and the columns' names and types
    l_cols := apex_plugin_util.get_data2(
                  p_sql_statement  => 'select sku, unit_price, launch_date from orb_products where sku like ''TNT%''',
                  p_min_columns    => 3,
                  p_max_columns    => 3,
                  p_component_name => 'P20_PRODUCT',
                  p_max_rows       => 2);
    for c in 1 .. l_cols.count loop
        dbms_output.put(rpad(l_cols(c).name || ' (' || l_cols(c).data_type || ')', 24));
    end loop;
    dbms_output.new_line;
    dbms_output.put_line(l_cols(1).value_list(1).varchar2_value || ' ' || l_cols(2).value_list(1).number_value
                         || ' ' || to_char(l_cols(3).value_list(1).date_value, 'DD-MON-YYYY'));

    -- the display value for a return value, as a Popup LOV shows it
    dbms_output.put_line('display of 2: ' || apex_plugin_util.get_display_data(
                             p_sql_statement => l_lov, p_min_columns => 2, p_max_columns => 2,
                             p_component_name => 'P20_PRODUCT', p_search_string => '2'));
    l_find(1) := '1'; l_find(2) := '3';
    l_list := apex_plugin_util.get_display_data(p_sql_statement => l_lov, p_min_columns => 2, p_max_columns => 2,
                  p_component_name => 'P20_PRODUCT', p_search_value_list => l_find);
    dbms_output.put_line('display of 1, 3: ' || l_list(1) || ', ' || l_list(2));
end;
/
