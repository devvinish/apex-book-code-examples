-- @session app=200 page=8
declare
    l_exec apex_background_process.t_execution;
begin
    -- the latest run of "Recalculate Totals", the background execution chain of page 8
    for r in (select execution_id, process_name from apex_appl_page_bg_proc_status
               where application_id = 200 and page_id = 8
               order by created_on desc fetch first 1 row only) loop
        l_exec := apex_background_process.get_execution(p_application_id => 200, p_execution_id => r.execution_id);
        dbms_output.put_line(r.process_name || ': ' || l_exec.state || ', ' || l_exec.sofar || ' of '
                             || l_exec.totalwork || ' orders' || case when l_exec.last_status_message is not null
                                                                      then ' - ' || l_exec.last_status_message end);
    end loop;
end;
/
