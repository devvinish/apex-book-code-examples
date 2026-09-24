-- Chapter 31: Ajax Callback GET_RECALC_PROGRESS (page 8)
declare
    l_done boolean := true;
begin
    apex_json.open_object;
    for s in (
        select status, status_code, sofar, totalwork
          from apex_appl_page_bg_proc_status
         where execution_id = :P8_RECALC_ID
    ) loop
        l_done := s.status_code in ('SUCCESS', 'FAILED', 'ABORTED');
        apex_json.write('status',    s.status);
        apex_json.write('sofar',     s.sofar);
        apex_json.write('totalwork', s.totalwork);
    end loop;
    apex_json.write('done', l_done);
    apex_json.close_object;

    if l_done then
        apex_util.set_session_state('P8_RECALC_ID', null);
    end if;
end;
