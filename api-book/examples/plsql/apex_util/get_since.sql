begin
    dbms_output.put_line(apex_util.get_since(sysdate - 2));
    dbms_output.put_line(apex_util.get_since(sysdate - 30/1440, p_short => 'Y'));
    dbms_output.put_line(apex_util.get_since(systimestamp + interval '3' hour));   -- TIMESTAMP overload
end;
/
