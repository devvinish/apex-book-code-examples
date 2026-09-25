-- @session app=200 page=1
declare
    l_response clob;
begin
    apex_web_service.set_request_headers(
        p_name_01  => 'Content-Type',    p_value_01 => 'application/json',
        p_name_02  => 'X-Orbit-Client',  p_value_02 => 'api-lab',
        p_reset    => true);                          -- start from no headers
    dbms_output.put_line('header: ' || apex_web_service.get_request_header('X-Orbit-Client'));

    -- httpbin.org echoes the request it receives
    l_response := apex_web_service.make_rest_request(
                      p_url         => 'https://httpbin.org/anything/orders',
                      p_http_method => 'POST',
                      p_body        => '{"sku":"TNT-1002","qty":2}');
    dbms_output.put_line('method: ' || json_value(l_response, '$.method'));
    dbms_output.put_line('json:   ' || json_query(l_response, '$.json'));
    dbms_output.put_line('client: ' || json_value(l_response, '$.headers."X-Orbit-Client"'));
    dbms_output.put_line('ecid:   ' || case when json_value(l_response, '$.headers."Ecid-Context"') is not null
                                            then 'sent' end);

    -- request headers stay set for the next request, until removed
    apex_web_service.remove_request_header('X-Orbit-Client');
    for i in 1 .. apex_web_service.g_request_headers.count loop
        dbms_output.put_line('left:   ' || apex_web_service.g_request_headers(i).name);
    end loop;
    apex_web_service.clear_request_headers;
    dbms_output.put_line('left:   ' || apex_web_service.g_request_headers.count || ' header(s)');
end;
/
