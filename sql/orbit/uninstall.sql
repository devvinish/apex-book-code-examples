-- Removes every Orbit Outfitters object from the current schema.
begin
    for o in (select object_name, object_type from user_objects
               where object_name like 'ORB\_%' escape '\'
                 and object_type in ('VIEW', 'PACKAGE', 'SEQUENCE', 'TABLE')
               order by decode(object_type, 'VIEW', 1, 'PACKAGE', 2, 'SEQUENCE', 3, 4)) loop
        execute immediate 'drop ' || o.object_type || ' ' || o.object_name
                       || case o.object_type when 'TABLE' then ' cascade constraints purge' end;
    end loop;
end;
/
