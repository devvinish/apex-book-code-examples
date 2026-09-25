-- @session app=200 page=1
declare
    l_params apex_exec.t_parameters;
begin
    -- a one-off synchronization with other parameter values: the sync type (REPLACE)
    -- and target table are the REST Data Source's
    apex_exec.add_parameter(l_params, 'name', 'Aurora');
    apex_rest_source_sync.dynamic_synchronize_data(
        p_module_static_id          => 'city-geocoding',
        p_sync_static_id            => 'aurora-us',
        p_sync_external_filter_expr => null,
        p_sync_parameters           => l_params);
end;
/

select name, admin1, country_code from lab_cities order by population desc nulls last fetch first 4 rows only;
