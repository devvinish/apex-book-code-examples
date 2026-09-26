-- @setup begin apex_util.set_workspace('APEXBOOK'); apex_credential.drop_credential('orbit-oauth'); exception when others then null; end;
begin
    apex_util.set_workspace('APEXBOOK');
    apex_credential.create_credential(
        p_credential_name      => 'ORBIT OAuth',
        p_credential_static_id => 'orbit-oauth',
        p_authentication_type  => apex_credential.c_type_oauth_client_cred,
        p_scope                => 'orders.read');
    apex_credential.set_persistent_credentials(p_credential_static_id => 'orbit-oauth',
                                               p_client_id => 'orbit-app', p_client_secret => 'client-secret');
    apex_credential.set_scope(p_credential_static_id => 'orbit-oauth', p_scope => 'orders.read orders.write');
    for c in (select credential_type, scope from apex_workspace_credentials where static_id = 'orbit-oauth') loop
        dbms_output.put_line(c.credential_type || ', scope: ' || c.scope);
    end loop;

    -- tokens obtained by other means, used instead of asking the token URL
    apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN');
    apex_credential.set_session_token(p_credential_static_id => 'orbit-oauth',
                                      p_token_type    => apex_credential.c_token_access,
                                      p_token_value   => 'session-token-1',
                                      p_token_expires => sysdate + 1/24);
    apex_credential.set_persistent_token(p_credential_static_id => 'orbit-oauth',
                                         p_token_type    => apex_credential.c_token_access,
                                         p_token_value   => 'shared-token-1',
                                         p_token_expires => sysdate + 1/24);
    apex_credential.clear_tokens(p_credential_static_id => 'orbit-oauth');   -- forget them again
    apex_session.delete_session;

    apex_util.set_workspace('APEXBOOK');
    apex_credential.drop_credential('orbit-oauth');
    dbms_output.put_line('tokens set, cleared, and the credential dropped');
end;
/
