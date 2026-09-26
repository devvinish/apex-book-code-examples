-- @session app=200 page=1
-- @setup begin execute immediate 'drop table lab_cities purge'; exception when others then null; end;
declare
    l_ddl clob;
begin
    -- the lab's REST Data Source "city-geocoding" synchronizes into the table LAB_CITIES,
    -- which does not exist yet: the definition SQL creates it
    l_ddl := apex_rest_source_sync.get_sync_table_definition_sql(p_module_static_id => 'city-geocoding');
    dbms_output.put_line(substr(l_ddl, 1, instr(l_ddl, '"ADMIN2"') - 1) || '...');

    apex_rest_source_sync.synchronize_table_definition(p_module_static_id => 'city-geocoding');

    apex_rest_source_sync.synchronize_data(p_module_static_id => 'city-geocoding');   -- uses the default name=Portland
    dbms_output.put_line('last sync: ' || case when apex_rest_source_sync.get_last_sync_timestamp('city-geocoding')
                                                    > systimestamp - interval '1' minute then 'just now' end);
    dbms_output.put_line('running: ' || case when apex_rest_source_sync.is_running(p_module_static_id => 'city-geocoding')
                                             then 'yes' else 'no' end);
end;
/

select count(*) as cities, min(name) as name from lab_cities;
