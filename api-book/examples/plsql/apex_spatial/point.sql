-- @session app=200 page=1
-- @setup begin execute immediate 'drop table lab_store_areas purge'; exception when others then null; end;
-- @setup begin delete user_sdo_geom_metadata where table_name = 'LAB_STORE_AREAS'; commit; end;
-- @setup create table lab_store_areas (store_id number primary key, name varchar2(100), area sdo_geometry)
declare
    l_geom sdo_geometry;
begin
    dbms_output.put_line('spatial available: ' || case when apex_spatial.spatial_is_available then 'yes' else 'no' end);

    -- register the column for spatial indexes, in longitude/latitude (SRID 4326)
    apex_spatial.insert_geom_metadata_lonlat(p_table_name => 'LAB_STORE_AREAS', p_column_name => 'AREA');

    l_geom := apex_spatial.point(p_lon => -104.9903, p_lat => 39.7392);
    dbms_output.put_line('point:     gtype ' || l_geom.sdo_gtype || ', srid ' || l_geom.sdo_srid);
    insert into lab_store_areas values (1, 'Denver store',
        apex_spatial.circle_polygon(p_lon => -104.9903, p_lat => 39.7392, p_radius => 5000));   -- 5 km
    insert into lab_store_areas values (2, 'Boulder region',
        apex_spatial.rectangle(p_lon1 => -105.30, p_lat1 => 39.95, p_lon2 => -105.15, p_lat2 => 40.10));

    for r in (select name, a.area.sdo_gtype as gtype,
                     round(sdo_geom.sdo_area(a.area, 0.05, 'unit=SQ_KM'), 1) as sq_km,
                     sdo_geom.relate(a.area, 'ANYINTERACT', apex_spatial.point(-104.99, 39.74), 0.05) as has_downtown
                from lab_store_areas a order by store_id) loop
        dbms_output.put_line(rpad(r.name, 15) || 'gtype ' || r.gtype || ', ' || r.sq_km || ' km2, downtown: ' || r.has_downtown);
    end loop;

    apex_spatial.change_geom_metadata(p_table_name => 'LAB_STORE_AREAS', p_column_name => 'AREA',
        p_diminfo => sdo_dim_array(sdo_dim_element('X', -180, 180, 1), sdo_dim_element('Y', -90, 90, 1)),
        p_srid => 4326);
    for m in (select column_name, srid from user_sdo_geom_metadata where table_name = 'LAB_STORE_AREAS') loop
        dbms_output.put_line('metadata:  ' || m.column_name || ', srid ' || m.srid);
    end loop;
    apex_spatial.delete_geom_metadata(p_table_name => 'LAB_STORE_AREAS', p_column_name => 'AREA');
    rollback;
end;
/
