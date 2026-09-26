-- @session app=200 page=1 user=ADMIN
-- @expect-error
declare
    l_email varchar2(200);
begin
    l_email := apex_app_setting.get_value(p_name => 'SUPPORT_EMAIL');
    dbms_output.put_line('SUPPORT_EMAIL: ' || l_email);
    apex_app_setting.set_value(p_name => 'SUPPORT_EMAIL', p_value => 'help@orbit-outfitters.example');
    dbms_output.put_line('changed:       ' || apex_app_setting.get_value('SUPPORT_EMAIL'));
    apex_app_setting.set_value('SUPPORT_EMAIL', l_email);                     -- put it back
    dbms_output.put_line('unknown:       ' || nvl(apex_app_setting.get_value('NO_SUCH_SETTING'), '(null)'));
    begin
        dbms_output.put_line(apex_app_setting.get_value('NO_SUCH_SETTING', p_raise_error => true));
    exception
        when others then dbms_output.put_line('p_raise_error: ' || substr(sqlerrm, 1, 80));
    end;
end;
/
