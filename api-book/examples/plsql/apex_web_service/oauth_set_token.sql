-- @session app=200 page=1
declare
    l_response clob;
begin
    -- a token obtained by other means than oauth_authenticate
    apex_web_service.oauth_set_token(p_token => 'orbit-demo-token', p_expires => sysdate + 1/24);
    dbms_output.put_line('last token: ' || apex_web_service.oauth_get_last_token);

    l_response := apex_web_service.make_rest_request(p_url => 'https://httpbin.org/bearer', p_http_method => 'GET');
    dbms_output.put_line('without header: ' || apex_web_service.g_status_code);

    -- in 26.1 the token is not added to requests by itself: send it as a header
    apex_web_service.set_request_headers('Authorization', 'Bearer ' || apex_web_service.oauth_get_last_token);
    l_response := apex_web_service.make_rest_request(p_url => 'https://httpbin.org/bearer', p_http_method => 'GET');
    dbms_output.put_line('with header:    ' || apex_web_service.g_status_code || ' ' || json_query(l_response, '$'));
    apex_web_service.clear_request_headers;
end;
/
