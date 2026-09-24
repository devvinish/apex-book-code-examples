-- Chapter 35: users and password checking for the "Orbit Users" custom authentication scheme.
-- Requires: grant execute on sys.dbms_crypto to orbit;

create table orb_app_users (
    user_id        number generated always as identity primary key,
    username       varchar2(100 char) not null,
    full_name      varchar2(200 char),
    password_hash  raw(64)            not null,
    password_salt  raw(16)            not null,
    is_active      varchar2(1 char)   default 'Y' not null,
    failed_logins  number             default 0   not null,
    last_login_on  date,
    constraint orb_app_users_uk        unique (username),
    constraint orb_app_users_active_ck check (is_active in ('Y', 'N'))
);

create or replace package orb_auth authid definer as
    -- Creates a user, or sets a new password for an existing one.
    procedure set_password (
        p_username  in varchar2,
        p_password  in varchar2,
        p_full_name in varchar2 default null);

    -- Authentication function of the custom authentication scheme.
    function authenticate (
        p_username in varchar2,
        p_password in varchar2) return boolean;

    -- Post-authentication procedure: records the time of the sign-in.
    procedure post_authenticate;
end orb_auth;
/

create or replace package body orb_auth as
    c_iterations   constant pls_integer := 20000;   -- PBKDF2 rounds
    c_max_failures constant pls_integer := 5;       -- lock after five wrong passwords

    -- PBKDF2 with HMAC-SHA512, one 64-byte block (RFC 8018).
    function pbkdf2 (p_password in varchar2, p_salt in raw) return raw is
        l_key raw(2000) := utl_i18n.string_to_raw(p_password, 'AL32UTF8');
        l_u   raw(64);
        l_t   raw(64);
    begin
        l_u := dbms_crypto.mac(utl_raw.concat(p_salt, hextoraw('00000001')),
                               dbms_crypto.hmac_sh512, l_key);
        l_t := l_u;
        for i in 2 .. c_iterations loop
            l_u := dbms_crypto.mac(l_u, dbms_crypto.hmac_sh512, l_key);
            l_t := utl_raw.bit_xor(l_t, l_u);
        end loop;
        return l_t;
    end pbkdf2;

    -- Counts a failed attempt, even though APEX rolls back the failed sign-in.
    procedure record_failure (p_user_id in number) is
        pragma autonomous_transaction;
    begin
        update orb_app_users
           set failed_logins = failed_logins + 1
         where user_id = p_user_id;
        commit;
    end record_failure;

    procedure set_password (
        p_username  in varchar2,
        p_password  in varchar2,
        p_full_name in varchar2 default null)
    is
        l_salt raw(16) := dbms_crypto.randombytes(16);
        l_hash raw(64) := pbkdf2(p_password, l_salt);
    begin
        merge into orb_app_users u
        using (select upper(p_username) as username from dual) s
           on (u.username = s.username)
         when matched then update
              set u.password_hash = l_hash,
                  u.password_salt = l_salt,
                  u.failed_logins = 0,
                  u.full_name     = nvl(p_full_name, u.full_name)
         when not matched then insert (username, full_name, password_hash, password_salt)
              values (s.username, p_full_name, l_hash, l_salt);
    end set_password;

    function authenticate (
        p_username in varchar2,
        p_password in varchar2) return boolean
    is
        l_user orb_app_users%rowtype;
        l_hash raw(64);
    begin
        select * into l_user
          from orb_app_users
         where username = upper(p_username);

        l_hash := pbkdf2(p_password, l_user.password_salt);

        if l_user.is_active = 'N' or l_user.failed_logins >= c_max_failures then
            return false;
        elsif l_hash = l_user.password_hash then
            return true;
        else
            record_failure(l_user.user_id);
            return false;
        end if;
    exception
        when no_data_found then
            -- Spend the same time as for a real user, so that timing does not reveal user names.
            l_hash := pbkdf2(p_password, hextoraw('00'));
            return false;
    end authenticate;

    procedure post_authenticate is
    begin
        update orb_app_users
           set last_login_on = sysdate,
               failed_logins = 0
         where username = upper(sys_context('APEX$SESSION', 'APP_USER'));
    end post_authenticate;
end orb_auth;
/
