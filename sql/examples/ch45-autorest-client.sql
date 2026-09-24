declare
    l_client ords_types.t_client_credentials;
begin
    ords.enable_object(
        p_enabled        => true,
        p_schema         => 'ORBIT',
        p_object         => 'ORB_PRODUCTS',
        p_object_type    => 'TABLE',
        p_object_alias   => 'products',
        p_auto_rest_auth => true);

    l_client := ords_security.register_client(
        p_name          => 'orbit_catalog_reader',
        p_grant_type    => 'client_credentials',
        p_support_email => 'it@orbit-outfitters.example',
        p_description   => 'Reads the Orbit product catalog',
        p_client_secret => ords_types.oauth_client_secret());

    ords_security.grant_client_role(
        p_client_name => 'orbit_catalog_reader',
        p_role_name   => 'oracle.dbtools.role.autorest.ORBIT.ORB_PRODUCTS');

    commit;

    dbms_output.put_line('client_id:     ' || l_client.client_key.client_id);
    dbms_output.put_line('client_secret: ' || l_client.client_secret.secret);
end;
