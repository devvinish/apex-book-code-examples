-- @session app=200 page=1 user=ADMIN
-- @expect-error
declare
    l_script clob;
begin
    l_script := apex_util.get_supporting_object_script(p_application_id => 200, p_script_type => 'INSTALL');
    dbms_output.put_line('install script: ' || dbms_lob.getlength(l_script) || ' characters');
exception
    when others then dbms_output.put_line(substr(sqlerrm, 1, 90));   -- the API Lab has no supporting objects
end;
/
