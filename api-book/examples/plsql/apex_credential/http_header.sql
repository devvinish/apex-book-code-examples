-- @setup begin apex_util.set_workspace('APEXBOOK'); apex_credential.drop_credential('httpbin-api-key'); exception when others then null; end;
declare
    l_response clob;
begin
    -- outside the lab: its Runtime API Usage does not allow changing the workspace
    apex_util.set_workspace('APEXBOOK');

    -- an API key sent as an HTTP header: the key is the header name, the value its value
    apex_credential.create_credential(
        p_credential_name      => 'httpbin API Key',
        p_credential_static_id => 'httpbin-api-key',
        p_authentication_type  => apex_credential.c_type_http_header,
        p_allowed_urls         => apex_t_varchar2('https://httpbin.org/'));
    apex_credential.set_persistent_credentials(p_credential_static_id => 'httpbin-api-key',
                                               p_key => 'X-Api-Key', p_value => 'orbit-key-123');
    apex_credential.set_allowed_urls(p_credential_static_id => 'httpbin-api-key',
                                     p_allowed_urls => apex_t_varchar2('https://httpbin.org/headers'),
                                     p_client_secret => 'orbit-key-123');   -- changing URLs needs the secret

    l_response := apex_web_service.make_rest_request(p_url => 'https://httpbin.org/headers',
                      p_http_method => 'GET', p_credential_static_id => 'httpbin-api-key');
    dbms_output.put_line('X-Api-Key: ' || json_value(l_response, '$.headers."X-Api-Key"'));

    for c in (select name, credential_type, valid_for_urls
                from apex_workspace_credentials where static_id = 'httpbin-api-key') loop
        dbms_output.put_line(c.name || ' - ' || c.credential_type || ' - ' || c.valid_for_urls);
    end loop;
    apex_credential.drop_credential('httpbin-api-key');
end;
/
