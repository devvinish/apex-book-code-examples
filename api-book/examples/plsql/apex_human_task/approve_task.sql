-- @session app=200 page=1
declare
    l_task number;
    procedure show(p_order number) is
    begin
        for t in (select t.state_code, t.outcome_code, o.status
                    from table(apex_human_task.get_tasks(p_context => apex_human_task.c_context_single_task,
                                                         p_task_id => l_task)) t
                    join orb_orders o on o.order_id = p_order) loop
            dbms_output.put_line('  task ' || t.state_code || ' ' || t.outcome_code || ', order ' || t.status);
        end loop;
    end;
begin
    l_task := apex_human_task.create_task(p_task_def_static_id => 'order-approval',
                                          p_detail_pk => '2259', p_initiator => 'KIM.LEE');
    apex_human_task.approve_task(p_task_id => l_task, p_autoclaim => true);   -- runs the action "Approve Order"
    dbms_output.put_line('approve_task:');
    show(2259);

    l_task := apex_human_task.create_task(p_task_def_static_id => 'order-approval',
                                          p_detail_pk => '2260', p_initiator => 'KIM.LEE');
    apex_human_task.claim_task(p_task_id => l_task);
    apex_human_task.reject_task(p_task_id => l_task);                          -- runs "Return Order"
    dbms_output.put_line('reject_task:');
    show(2260);

    -- an action task has no approve or reject: complete it, with or without an outcome
    l_task := apex_human_task.create_task(p_task_def_static_id => 'shipment-confirmation',
                                          p_detail_pk => '2262', p_initiator => 'KIM.LEE');
    apex_human_task.complete_task(p_task_id => l_task, p_autoclaim => true);
    dbms_output.put_line('complete_task:');
    show(2262);
    rollback;   -- tasks and orders as they were
end;
/
