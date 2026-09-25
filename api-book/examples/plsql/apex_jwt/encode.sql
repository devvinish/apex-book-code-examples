declare
    l_key   raw(64) := utl_raw.cast_to_raw('orbit-signing-key-0123456789abcdef');
    l_jwt   varchar2(4000);
    l_token apex_jwt.t_token;

    procedure check_token(p_label varchar2, p_jwt varchar2, p_key raw) is
        l_t apex_jwt.t_token;
    begin
        l_t := apex_jwt.decode(p_value => p_jwt, p_signature_key => p_key);   -- checks the signature
        apex_jwt.validate(p_token => l_t, p_iss => 'orbit', p_aud => 'api-lab');   -- iss, aud, exp, nbf
        dbms_output.put_line(rpad(p_label, 10) || 'valid');
    exception when value_error then
        dbms_output.put_line(rpad(p_label, 10) || 'VALUE_ERROR');
    end;
begin
    l_jwt := apex_jwt.encode(
                 p_iss           => 'orbit',
                 p_sub           => 'ADMIN',
                 p_aud           => 'api-lab',
                 p_iat_ts        => timestamp '2026-03-14 09:30:00 +00:00',
                 p_exp_sec       => 3600,
                 p_other_claims  => '"role":' || apex_json.stringify('manager'),
                 p_signature_key => l_key);                 -- HS256
    dbms_output.put_line(l_jwt);

    l_token := apex_jwt.decode(p_value => l_jwt);          -- without a key: no signature check
    dbms_output.put_line('header:  ' || l_token.header);
    dbms_output.put_line('payload: ' || l_token.payload);

    check_token('expired', l_jwt, l_key);                  -- issued in March, valid for an hour
    l_jwt := apex_jwt.encode(p_iss => 'orbit', p_aud => 'api-lab', p_exp_sec => 3600,
                             p_signature_key => l_key);    -- issued now
    check_token('fresh', l_jwt, l_key);
    check_token('wrong key', l_jwt, utl_raw.cast_to_raw('another-key-0123456789abcdefghij'));
end;
/
