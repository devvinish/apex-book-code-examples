-- @session app=200 page=1
-- @setup begin execute immediate 'drop table lab_city_copy'; exception when others then null; end;
-- @setup create table lab_city_copy (name varchar2(200), admin1 varchar2(200), population number)
declare
    l_params  apex_exec.t_parameters;
    l_columns apex_exec.t_columns;
    l_from    apex_exec.t_context;
    l_to      apex_exec.t_context;
begin
    -- copy rows from a REST Data Source into a local table, column by column in order
    apex_exec.add_parameter(l_params, 'name', 'Portland');
    apex_exec.add_column(l_columns, 'NAME',       apex_exec.c_data_type_varchar2);
    apex_exec.add_column(l_columns, 'ADMIN1',     apex_exec.c_data_type_varchar2);
    apex_exec.add_column(l_columns, 'POPULATION', apex_exec.c_data_type_number);

    l_from := apex_exec.open_rest_source_query(p_static_id => 'city-geocoding', p_parameters => l_params,
                                               p_columns => l_columns, p_max_rows => 5);
    l_to   := apex_exec.open_local_dml_context(p_columns => l_columns,
                                               p_query_type => apex_exec.c_query_type_table,
                                               p_table_name => 'LAB_CITY_COPY');
    apex_exec.copy_data(p_from_context => l_from, p_to_context => l_to);   -- inserts every row
    apex_exec.close(l_from);
    apex_exec.close(l_to);
end;
/

select name, admin1, population from lab_city_copy order by population desc nulls last;
