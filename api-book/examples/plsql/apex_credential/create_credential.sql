-- @setup begin apex_util.set_workspace('APEXBOOK'); apex_credential.drop_credential('httpbin-basic'); exception when others then null; end;
declare
    l_response clob;
begin
    -- outside the lab app: its Runtime API Usage does not allow changing the workspace
    apex_util.set_workspace('APEXBOOK');

    -- a Web Credential of the workspace, usable only for the allowed URLs
    apex_credential.create_credential(
        p_credential_name       => 'httpbin Basic',
        p_credential_static_id  => 'httpbin-basic',
        p_authentication_type   => apex_credential.c_type_basic,
        p_allowed_urls          => apex_t_varchar2('https://httpbin.org/'));
    -- stored encrypted, for all sessions
    apex_credential.set_persistent_credentials(p_credential_static_id => 'httpbin-basic',
                                               p_username => 'orbit', p_password => 'secret-1');
    commit;

    apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN');
    l_response := apex_web_service.make_rest_request(
                      p_url                  => 'https://httpbin.org/basic-auth/orbit/secret-1',
                      p_http_method          => 'GET',
                      p_credential_static_id => 'httpbin-basic');
    dbms_output.put_line('persistent: ' || apex_web_service.g_status_code || ' ' || json_value(l_response, '$.user'));

    -- for this APEX session only, overriding the stored values
    apex_credential.set_session_credentials(p_credential_static_id => 'httpbin-basic',
                                            p_username => 'orbit', p_password => 'secret-2');
    l_response := apex_web_service.make_rest_request(
                      p_url                  => 'https://httpbin.org/basic-auth/orbit/secret-1',
                      p_http_method          => 'GET',
                      p_credential_static_id => 'httpbin-basic');
    dbms_output.put_line('session:    ' || apex_web_service.g_status_code);

    -- a URL outside the allowed ones
    begin
        l_response := apex_web_service.make_rest_request(p_url => 'https://postman-echo.com/basic-auth',
                          p_http_method => 'GET', p_credential_static_id => 'httpbin-basic');
    exception when others then
        dbms_output.put_line('other URL:  ' || regexp_substr(regexp_replace(sqlerrm, 'ORA-\d+: '), '[^' || chr(10) || ']+'));
    end;
    apex_session.delete_session;

    apex_util.set_workspace('APEXBOOK');
    apex_credential.drop_credential(p_credential_static_id => 'httpbin-basic');
end;
/
