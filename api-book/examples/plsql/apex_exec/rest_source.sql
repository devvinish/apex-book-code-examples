-- @session app=200 page=1
declare
    l_params  apex_exec.t_parameters;
    l_filters apex_exec.t_filters;
    l_context apex_exec.t_context;
begin
    -- the lab's REST Data Source "city-geocoding" (Open-Meteo) has a query parameter "name"
    apex_exec.add_parameter(l_params, 'name', 'Salem');
    apex_exec.add_filter(l_filters, apex_exec.c_filter_eq, 'COUNTRY_CODE', 'US');   -- applied locally

    l_context := apex_exec.open_rest_source_query(
                     p_static_id  => 'city-geocoding',
                     p_parameters => l_params,
                     p_filters    => l_filters,
                     p_max_rows   => 3);
    while apex_exec.next_row(l_context) loop
        dbms_output.put(rpad(apex_exec.get_varchar2(l_context, 'NAME') || ', '
                             || apex_exec.get_varchar2(l_context, 'ADMIN1'), 26)
            || to_char(apex_exec.get_number(l_context, 'POPULATION'), '999G990') || '  zip');
        -- POSTCODES is an array column: step into it, row by row
        apex_exec.open_array(l_context, 'POSTCODES');
        while apex_exec.next_array_row(l_context) loop
            dbms_output.put(' ' || apex_exec.get_varchar2(l_context, 'POSTCODES2'));
        end loop;
        apex_exec.close_array(l_context);
        dbms_output.new_line;
    end loop;
    apex_exec.close(l_context);

    -- run an operation directly; the OUT parameter RESPONSE receives the response body
    apex_exec.execute_rest_source(p_static_id => 'city-geocoding', p_operation => 'GET',
                                  p_parameters => l_params);
    dbms_output.put_line(substr(apex_exec.get_parameter_clob(l_params, 'RESPONSE'), 1, 60) || '...');

    apex_exec.purge_rest_source_cache(p_static_id => 'city-geocoding');   -- if caching is on
end;
/
