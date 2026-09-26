-- @session app=200 page=1
declare
    l_response clob;
begin
    -- p_parm_name/p_parm_value: sent as an HTML form; the Content-Type header is needed
    apex_web_service.set_request_headers('Content-Type', 'application/x-www-form-urlencoded');
    l_response := apex_web_service.make_rest_request(
                      p_url         => 'https://httpbin.org/post',
                      p_http_method => 'POST',
                      p_parm_name   => apex_string.string_to_table('sku:qty'),
                      p_parm_value  => apex_string.string_to_table('TNT-1002:2'));
    dbms_output.put_line('form: ' || json_query(l_response, '$.form'));
    dbms_output.put_line('type: ' || json_value(l_response, '$.headers."Content-Type"'));

    apex_web_service.clear_request_headers;

    -- a cookie for the next request (domain and path are required);
    -- the cookies of a response arrive in g_response_cookies
    apex_web_service.g_request_cookies(1).name   := 'orbit_region';
    apex_web_service.g_request_cookies(1).value  := 'west';
    apex_web_service.g_request_cookies(1).domain := 'httpbin.org';
    apex_web_service.g_request_cookies(1).path   := '/';
    l_response := apex_web_service.make_rest_request(p_url => 'https://httpbin.org/cookies',
                                                     p_http_method => 'GET');
    dbms_output.put_line('cookies: ' || json_query(l_response, '$.cookies'));
    apex_web_service.clear_request_cookies;
    dbms_output.put_line('request cookies now: ' || apex_web_service.g_request_cookies.count);
end;
/
