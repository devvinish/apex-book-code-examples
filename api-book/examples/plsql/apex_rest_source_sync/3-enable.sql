-- @session app=200 page=1
declare
    procedure show(p_label varchar2) is
    begin
        for m in (select sync_is_active, next_synchronization from apex_appl_web_src_modules
                   where application_id = 200 and module_static_id = 'city-geocoding') loop
            dbms_output.put_line(rpad(p_label, 12) || 'active: ' || m.sync_is_active || ', next: '
                || case when m.next_synchronization is null then '-'
                        when m.next_synchronization > systimestamp + interval '1' day then 'in more than a day'
                        else 'within a day' end);
        end loop;
    end;
begin
    show('initially');
    apex_rest_source_sync.enable(p_module_static_id => 'city-geocoding');     -- schedules the job
    show('enabled');
    apex_rest_source_sync.reschedule(p_module_static_id => 'city-geocoding',
                                     p_next_run_at => systimestamp + interval '2' day);
    show('rescheduled');
    apex_rest_source_sync.disable(p_module_static_id => 'city-geocoding');
    show('disabled');
end;
/
