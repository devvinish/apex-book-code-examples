-- @session app=200 page=1
declare
    l_parts    apex_web_service.t_multipart_parts;
    l_body     blob;
    l_response clob;
begin
    apex_web_service.append_to_multipart(p_multipart => l_parts, p_name => 'orderNumber', p_body => 'ORD-10042');
    apex_web_service.append_to_multipart(p_multipart => l_parts, p_name => 'invoice',
                                         p_filename  => 'ORD-10042.csv', p_content_type => 'text/csv',
                                         p_body_blob => apex_util.clob_to_blob('sku,qty' || chr(10) || 'TNT-1002,2'));
    l_body := apex_web_service.generate_request_body(p_multipart => l_parts);

    -- generate_request_body sets the Content-Type header with the boundary
    l_response := apex_web_service.make_rest_request(p_url => 'https://httpbin.org/post',
                                                     p_http_method => 'POST', p_body_blob => l_body);
    dbms_output.put_line('type:  ' || regexp_substr(json_value(l_response, '$.headers."Content-Type"'), '^[^;]+'));
    dbms_output.put_line('form:  ' || json_query(l_response, '$.form'));
    dbms_output.put_line('files: ' || json_query(l_response, '$.files'));
    apex_web_service.clear_request_headers;
end;
/
