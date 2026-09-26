-- @session app=200 page=1
declare
    l_task number;
    procedure owners is
        l_list varchar2(400);
    begin
        select listagg(participant_type || ':' || participant, ' ') within group (order by participant_type, participant)
          into l_list from apex_task_participants where task_id = l_task and participant_type <> 'INITIATOR';
        dbms_output.put_line('  ' || l_list);
    end;
begin
    l_task := apex_human_task.create_task(p_task_def_static_id => 'shipment-confirmation',
                                          p_detail_pk => '2262', p_initiator => 'KIM.LEE');
    owners;
    apex_human_task.add_task_potential_owner(p_task_id => l_task, p_potential_owner => 'JO.PARK');
    apex_human_task.add_task_potential_owner(p_task_id => l_task, p_potential_owner => 'SAM.ROY');
    owners;

    for d in (select disp, val from table(apex_human_task.get_task_delegates(p_task_id => l_task))) loop
        dbms_output.put_line('  could delegate to: ' || d.disp);
    end loop;
    -- ADMIN, the only potential owner at creation, owns the task already
    apex_human_task.delegate_task(p_task_id => l_task, p_to_user => 'JO.PARK');   -- JO.PARK is the owner now
    for t in (select actual_owner, state_code from table(apex_human_task.get_tasks(
                  p_context => apex_human_task.c_context_single_task, p_task_id => l_task))) loop
        dbms_output.put_line('  delegated: owner ' || t.actual_owner || ', ' || t.state_code);
    end loop;

    apex_human_task.remove_potential_owner(p_task_id => l_task, p_potential_owner => 'SAM.ROY');
    apex_human_task.exclude_potential_owner(p_task_id => l_task, p_potential_owner => 'ADMIN');
    owners;

    dbms_output.put_line('ADMIN business admin: ' || case when apex_human_task.is_business_admin(p_user => 'ADMIN') then 'yes' else 'no' end);
    dbms_output.put_line('JO.PARK potential owner: ' || case when apex_human_task.is_of_participant_type(
        p_task_id => l_task, p_participant_type => apex_human_task.c_task_potential_owner, p_user => 'JO.PARK') then 'yes' else 'no' end);
    rollback;
end;
/
