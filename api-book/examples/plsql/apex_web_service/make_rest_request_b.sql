-- @session app=200 page=1
declare
    l_png    blob;
    l_base64 clob;
begin
    l_png := apex_web_service.make_rest_request_b(p_url => 'https://httpbin.org/image/png',
                                                  p_http_method => 'GET');
    dbms_output.put_line(apex_web_service.g_status_code || ': ' || dbms_lob.getlength(l_png) || ' bytes, starts with '
                         || utl_raw.cast_to_varchar2(dbms_lob.substr(l_png, 3, 2)));

    -- Base64, for JSON payloads and data: URLs; p_newlines => 'N' gives one line
    l_base64 := apex_web_service.blob2clobbase64(p_blob => l_png, p_newlines => 'N');
    dbms_output.put_line('base64: ' || dbms_lob.getlength(l_base64) || ' chars: ' || substr(l_base64, 1, 24) || '...');
    dbms_output.put_line('decoded: ' || dbms_lob.getlength(apex_web_service.clobbase642blob(l_base64)) || ' bytes');
end;
/
