select 'state' as lov, disp, val from table(apex_human_task.get_lov_state)
union all
select 'priority', disp, val from table(apex_human_task.get_lov_priority)
union all
select 'type', disp, val from table(apex_human_task.get_lov_type);
