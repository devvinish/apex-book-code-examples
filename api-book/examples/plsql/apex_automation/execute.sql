-- @session app=200 page=1
declare
    l_filters apex_exec.t_filters;
    procedure show(p_label varchar2) is
    begin
        for a in (select polling_status, polling_next_run_timestamp as next_run from apex_appl_automations
                   where application_id = 200 and static_id = 'remind-pending-approvals') loop
            dbms_output.put_line(rpad(p_label, 12) || a.polling_status || ', next run: '
                || case when a.next_run is null then '-' when a.next_run > systimestamp + interval '1' day then 'in 2 days'
                        else 'within a day' end);
        end loop;
    end;
begin
    -- the lab's "Remind Pending Approvals" e-mails a reminder per order awaiting approval
    dbms_output.put_line('job: ' || apex_automation.get_scheduler_job_name(p_static_id => 'remind-pending-approvals'));
    show('initially');
    apex_automation.enable(p_static_id => 'remind-pending-approvals');
    show('enabled');
    apex_automation.reschedule(p_static_id => 'remind-pending-approvals', p_next_run_at => systimestamp + interval '2' day);
    show('rescheduled');
    apex_automation.disable(p_static_id => 'remind-pending-approvals');
    show('disabled');

    -- run it now, for one order only (it commits, and queues one e-mail)
    apex_exec.add_filter(l_filters, apex_exec.c_filter_eq, 'ORDER_ID', 2259);
    apex_automation.execute(p_static_id => 'remind-pending-approvals', p_filters => l_filters);
    dbms_output.put_line('running: ' || case when apex_automation.is_running(p_static_id => 'remind-pending-approvals')
                                             then 'yes' else 'no' end
        || ', last run: ' || case when apex_automation.get_last_run_timestamp(p_static_id => 'remind-pending-approvals')
                                       > systimestamp - interval '1' minute then 'just now' end);
    for l in (select status, successful_row_count, error_row_count from apex_automation_log
               where application_id = 200 and automation_static_id = 'remind-pending-approvals'
               order by start_timestamp desc fetch first 1 row only) loop
        dbms_output.put_line('log: ' || l.status || ', ' || l.successful_row_count || ' row(s), '
                             || l.error_row_count || ' error(s)');
    end loop;
end;
/
