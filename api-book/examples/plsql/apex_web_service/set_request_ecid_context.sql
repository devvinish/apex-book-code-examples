-- @session app=200 page=1
declare
    l_response clob;
begin
    -- APEX sends an ECID-Context header, to trace a request across servers; set your own ID
    apex_web_service.set_request_ecid_context(p_ecid => 'ORBIT-TRACE-0042');
    l_response := apex_web_service.make_rest_request(p_url => 'https://httpbin.org/headers', p_http_method => 'GET');
    dbms_output.put_line(json_value(l_response, '$.headers."Ecid-Context"'));
end;
/
