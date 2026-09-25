-- @setup begin apex_util.set_workspace('APEXBOOK'); apex_acl.replace_user_roles(p_application_id => 200, p_user_name => 'KIM.LEE', p_role_static_ids => apex_t_varchar2('READER')); commit; end;
declare
    procedure show(p_label varchar2) is
    begin
        dbms_output.put(rpad(p_label, 16));
        for a in (select authorization_scheme_name as name, static_id from apex_application_authorization
                   where application_id = 200 order by 1) loop
            dbms_output.put(case when apex_authorization.is_authorized(p_authorization_name => a.name)
                                 then 'yes ' else 'no  ' end);
        end loop;
        dbms_output.put_line('/ approve by static ID: ' ||
            case when apex_authorization.has_access(p_static_id => 'can-approve-orders') then 'yes' else 'no' end);
    end;
begin
    dbms_output.put_line(rpad(' ', 16) || 'Adm Apr Con Rea');
    apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'ADMIN');
    show('ADMIN');
    apex_session.delete_session;

    apex_session.create_session(p_app_id => 200, p_page_id => 1, p_username => 'KIM.LEE');
    show('KIM.LEE cached');    -- results cached per page view come from ADMIN's request
    apex_authorization.reset_cache;
    show('KIM.LEE reset');
    apex_session.delete_session;
end;
/
