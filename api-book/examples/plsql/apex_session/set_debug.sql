-- @session app=200 page=1 user=ADMIN
-- @expect-error
begin
    apex_session.set_debug(p_level => apex_debug.c_log_level_info);   -- this session's next requests
    apex_session.set_trace(p_mode => 'SQL');
    apex_session.set_tenant_id(p_tenant_id => 'ORBIT-EU');
    dbms_output.put_line('APP_TENANT_ID: ' || v('APP_TENANT_ID'));
    begin
        apex_session.set_tenant_id(p_tenant_id => 'ORBIT-US');
    exception
        when others then dbms_output.put_line('second set_tenant_id: ' || substr(sqlerrm, 1, 72));
    end;
    commit;                                               -- the settings are stored at commit
end;
/
