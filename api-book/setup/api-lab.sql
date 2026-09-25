-- Creates the API Lab: application 200, alias api-lab, from f200.sql in this folder.
-- Run in SQLcl or SQL*Plus as the owner of the ORBIT sample schema (sql/orbit of
-- https://github.com/devvinish/apex-book-code-examples), from this folder:
--   sql orbit@localhost:1521/FREEPDB1 @api-lab.sql
-- Change APEXBOOK and ADMIN below if your workspace or workspace user has another name.
begin
    apex_application_install.set_workspace('APEXBOOK');
    apex_application_install.set_application_id(200);
    apex_application_install.generate_offset;
    apex_application_install.set_schema('ORBIT');
    apex_application_install.set_application_alias('API-LAB');
    apex_application_install.set_application_name('API Lab');
end;
/
@f200.sql

-- The application checks Application Access Control on every page: give ADMIN the roles
-- Administrator and Approver.
begin
    apex_util.set_workspace('APEXBOOK');
    for r in (select role_id
                from apex_appl_acl_roles
               where application_id = 200
                 and role_static_id in ('ADMINISTRATOR', 'approver')) loop
        apex_acl.add_user_role(p_application_id => 200, p_user_name => 'ADMIN', p_role_id => r.role_id);
    end loop;
    commit;
end;
/
