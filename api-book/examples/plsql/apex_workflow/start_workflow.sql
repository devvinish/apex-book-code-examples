-- @session app=200 page=1
declare
    l_wf   number;
    l_task number;
    l_vars apex_workflow.t_workflow_parameters;

    -- workflows run in a background job: wait for a condition, up to a minute
    function waited(p_sql varchar2) return boolean is
        l_n number;
    begin
        for i in 1 .. 60 loop
            execute immediate p_sql into l_n using l_wf;
            if l_n > 0 then return true; end if;
            dbms_session.sleep(1);
        end loop;
        return false;
    end;
    procedure show(p_label varchar2) is
    begin
        dbms_output.put_line(p_label || ': workflow ' || apex_workflow.get_workflow_state(p_instance_id => l_wf));
        for a in (select name, state from apex_workflow_activities where workflow_id = l_wf order by start_time, name) loop
            dbms_output.put_line('  ' || rpad(a.name, 18) || a.state);
        end loop;
    end;
begin
    -- start "Order Fulfillment" for the approved order ORD-12263 (it commits)
    l_wf := apex_workflow.start_workflow(p_static_id => 'order-fulfillment', p_detail_pk => '2263',
                                         p_initiator => 'KIM.LEE');
    for w in (select title, initiator, workflow_version from table(apex_workflow.get_workflows(
                  p_context => apex_workflow.c_context_single_workflow, p_workflow_id => l_wf))) loop
        dbms_output.put_line(w.title || ', version ' || w.workflow_version || ', started by ' || w.initiator);
    end loop;

    if waited('select count(*) from apex_tasks where workflow_id = :1') then
        show('task created');
    end if;

    -- workflow variables can be changed while the workflow is suspended
    apex_workflow.suspend(p_instance_id => l_wf);
    dbms_output.put_line('suspended: ' || apex_workflow.get_workflow_state(p_instance_id => l_wf));
    l_vars(1).static_id    := 'APPROVER';
    l_vars(1).string_value := 'ADMIN';
    apex_workflow.update_variables(p_instance_id => l_wf, p_changed_params => l_vars);
    dbms_output.put_line('APPROVER = ' || apex_workflow.get_variable_value(p_instance_id => l_wf, p_variable_static_id => 'APPROVER'));
    apex_workflow.resume(p_instance_id => l_wf);
    dbms_output.put_line('resumed: ' || apex_workflow.get_workflow_state(p_instance_id => l_wf));

    -- complete the shipment confirmation: the workflow goes on
    select task_id into l_task from apex_tasks where workflow_id = l_wf;
    apex_human_task.complete_task(p_task_id => l_task, p_autoclaim => true);
    commit;
    if waited(q'~select count(*) from apex_workflows where workflow_id = :1 and state_code = 'COMPLETED'~') then
        show('task completed');
    end if;
    for o in (select status, replace(regexp_replace(notes, '\d{4}-\d\d-\d\d \d\d:\d\d ', ''), chr(10), ', ') as notes
                from orb_orders where order_id = 2263) loop
        dbms_output.put_line('order: ' || o.status || ' (' || o.notes || ')');
    end loop;

    -- put the lab back: the order, and the workflow with its task
    update orb_orders set status = 'APPROVED', shipped_date = null, notes = null where order_id = 2263;
    apex_workflow.delete_workflows(p_application_id => 200, p_static_id => 'order-fulfillment',
                                   p_include_all_versions => true);
    apex_human_task.delete_tasks(p_application_id => 200, p_include_workflow_tasks => true);
    commit;
end;
/
