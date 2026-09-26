declare
    l_geom sdo_geometry;
begin
    apex_json.parse('{"store":"Denver Flagship",'
                 || '"location":{"type":"Point","coordinates":[-104.9903,39.7392]}}');
    l_geom := apex_json.get_sdo_geometry('location');   -- GeoJSON -> SDO_GEOMETRY
    dbms_output.put_line('gtype ' || l_geom.sdo_gtype || ', srid ' || l_geom.sdo_srid
        || ', x ' || l_geom.sdo_point.x || ', y ' || l_geom.sdo_point.y);
end;
/
