-- @session app=200 page=1
declare
    l_response clob;
begin
    -- the ORBIT schema's ORDS module orbit.sales, on the local ORDS
    l_response := apex_web_service.make_rest_request(
                      p_url         => 'http://host.docker.internal:8080/ords/orbit/sales/orders/',
                      p_http_method => 'GET');

    dbms_output.put_line('status: ' || apex_web_service.g_status_code || ' ' || apex_web_service.g_reason_phrase);
    for i in 1 .. apex_web_service.g_headers.count loop
        if apex_web_service.g_headers(i).name = 'Content-Type' then
            dbms_output.put_line('type:   ' || apex_web_service.g_headers(i).value);
        end if;
    end loop;

    for r in (select * from json_table(l_response, '$.items[*]'
                                       columns (order_number, status, order_total number))
               fetch first 3 rows only) loop
        dbms_output.put_line(r.order_number || ' ' || rpad(r.status, 10) || r.order_total);
    end loop;
end;
/
