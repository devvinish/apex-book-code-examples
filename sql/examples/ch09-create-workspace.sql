-- Run as SYS in the pluggable database, for example FREEPDB1. Replace both passwords.
create user orbit identified by "<schema password>"
    default tablespace users quota unlimited on users;

grant create session, create table, create view, create sequence, create procedure,
      create trigger, create type, create synonym, create materialized view,
      create job, create mle, create property graph to orbit;
grant db_developer_role to orbit;
grant execute on sys.dbms_crypto to orbit;

begin
    apex_instance_admin.add_workspace(
        p_workspace      => 'APEXBOOK',
        p_primary_schema => 'ORBIT');

    apex_util.set_workspace('APEXBOOK');
    apex_util.create_user(
        p_user_name                    => 'ADMIN',
        p_first_name                   => 'Book',
        p_last_name                    => 'Administrator',
        p_email_address                => 'admin@orbit-outfitters.example',
        p_web_password                 => '<administrator password>',
        p_developer_privs              => 'ADMIN:CREATE:DATA_LOADER:EDIT:HELP:MONITOR:SQL',
        p_default_schema               => 'ORBIT',
        p_change_password_on_first_use => 'N');
    commit;
end;
/
