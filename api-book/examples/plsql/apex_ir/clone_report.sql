-- @session app=200 page=8
declare
    l_primary number;
    l_new     number;
begin
    select report_id into l_primary from apex_application_page_ir_rpt
     where application_id = 200 and page_id = 8 and report_type = 'PRIMARY_DEFAULT';

    -- a copy of the primary report, saved as a private report of KIM.LEE
    l_new := apex_ir.clone_report(p_report_id => l_primary, p_new_name => 'My Orders',
                                  p_new_owner => 'KIM.LEE', p_new_is_public => false);
    apex_ir.change_report_owner(p_report_id => l_new, p_old_owner => 'KIM.LEE', p_new_owner => 'JO.PARK');

    for r in (select report_name, application_user, report_type, status from apex_application_page_ir_rpt
               where report_id = l_new) loop
        dbms_output.put_line(r.report_name || ' - ' || r.application_user || ' - ' || r.report_type || ' - ' || r.status);
    end loop;

    apex_ir.delete_report(p_report_id => l_new);
    select count(*) into l_new from apex_application_page_ir_rpt where application_id = 200 and report_name = 'My Orders';
    dbms_output.put_line('left after delete_report: ' || l_new);
end;
/
