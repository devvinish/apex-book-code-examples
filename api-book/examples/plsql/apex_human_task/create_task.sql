-- @session app=200 page=1
declare
    l_task number;
    procedure show is
    begin
        for t in (select * from table(apex_human_task.get_tasks(p_context => apex_human_task.c_context_single_task,
                                                                p_task_id => l_task))) loop
            dbms_output.put_line('  ' || t.state_code || ', priority ' || t.priority || ', owner '
                                 || nvl(t.actual_owner, '-') || ', due ' || to_char(t.due_on, 'DD-MON-YYYY HH24:MI'));
        end loop;
    end;
begin
    -- an approval of order ORD-12259, requested by the sales representative KIM.LEE;
    -- ADMIN is a potential owner through the authorization "Can Approve Orders"
    l_task := apex_human_task.create_task(
                  p_application_id     => 200,
                  p_task_def_static_id => 'order-approval',
                  p_detail_pk          => '2259',          -- :APEX$TASK_PK in the task definition
                  p_initiator          => 'KIM.LEE');
    for t in (select subject, initiator from table(apex_human_task.get_tasks(
                  p_context => apex_human_task.c_context_single_task, p_task_id => l_task))) loop
        dbms_output.put_line(t.subject || ' (from ' || t.initiator || ')');
    end loop;
    show;

    dbms_output.put_line('may claim:   ' || case when apex_human_task.is_allowed(l_task, apex_human_task.c_task_op_claim) then 'yes' else 'no' end);
    dbms_output.put_line('may approve: ' || case when apex_human_task.is_allowed(l_task, apex_human_task.c_task_op_approve) then 'yes' else 'no' end);

    apex_human_task.claim_task(p_task_id => l_task);                          -- ADMIN becomes the owner
    apex_human_task.set_task_priority(p_task_id => l_task, p_priority => apex_human_task.c_task_priority_urgent);
    apex_human_task.set_task_due(p_task_id => l_task, p_due_date => timestamp '2026-10-01 12:00:00 +00:00');
    apex_human_task.add_task_comment(p_task_id => l_task, p_text => 'The discount is above 15%.');
    show;
    dbms_output.put_line('may approve: ' || case when apex_human_task.is_allowed(l_task, apex_human_task.c_task_op_approve) then 'yes' else 'no' end);

    -- ask the initiator a question: the task waits for the answer
    apex_human_task.request_more_information(p_task_id => l_task, p_text => 'Why this discount?', p_to_user => 'KIM.LEE');
    show;

    for h in (select event_type, event_creator, display_msg
                from table(apex_human_task.get_task_history(p_task_id => l_task))
               order by event_timestamp) loop
        dbms_output.put_line(rpad(h.event_type, 22) || rpad(h.event_creator, 8) || h.display_msg);
    end loop;
    rollback;   -- the task is gone again
end;
/
