-- @session app=200 page=1
declare
    l_wf number;
begin
    l_wf := apex_workflow.start_workflow(p_static_id => 'order-fulfillment', p_detail_pk => '2264',
                                         p_initiator => 'KIM.LEE');
    apex_workflow.set_log_level(p_instance_id => l_wf, p_debug_level => apex_debug.c_log_level_info);

    dbms_output.put_line('ADMIN is workflow admin:  ' || case when apex_workflow.is_admin(p_user => 'ADMIN') then 'yes' else 'no' end);
    dbms_output.put_line('ADMIN is owner:           ' || case when apex_workflow.is_of_participant_type(
        p_instance_id => l_wf, p_participant_type => apex_workflow.c_workflow_owner, p_user => 'ADMIN') then 'yes' else 'no' end);
    dbms_output.put_line('KIM.LEE may terminate:    ' || case when apex_workflow.is_allowed(
        p_instance_id => l_wf, p_operation => apex_workflow.c_workflow$_op_terminate, p_user => 'KIM.LEE') then 'yes' else 'no' end);
    dbms_output.put_line('ADMIN may terminate:      ' || case when apex_workflow.is_allowed(
        p_instance_id => l_wf, p_operation => apex_workflow.c_workflow$_op_terminate, p_user => 'ADMIN') then 'yes' else 'no' end);

    apex_workflow.terminate(p_instance_id => l_wf);
    dbms_output.put_line('state: ' || apex_workflow.get_workflow_state(p_instance_id => l_wf));

    apex_workflow.delete_workflows(p_application_id => 200, p_static_id => 'order-fulfillment',
                                   p_states => apex_t_varchar2(apex_workflow.c_state_terminated),
                                   p_include_all_versions => true);
    apex_human_task.delete_tasks(p_application_id => 200, p_include_workflow_tasks => true);
    update orb_orders set notes = null where order_id = 2264;     -- notes a quick activity may have added
    commit;
    dbms_output.put_line('next purge: ' || case when apex_workflow.get_next_purge_timestamp > systimestamp then 'scheduled' end);
end;
/

select disp, val from table(apex_workflow.get_lov_workflow_state);
