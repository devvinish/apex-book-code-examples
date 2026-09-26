-- @session app=200 page=20 user=ADMIN
declare
    l_value apex_session_state.t_value;
begin
    apex_session_state.set_value('P20_TEXTAREA', to_clob(rpad('x', 32767, 'x')) || rpad('y', 8000, 'y'), p_commit => false);
    dbms_output.put_line('get_clob:     ' || length(apex_session_state.get_clob('P20_TEXTAREA')) || ' characters');
    dbms_output.put_line('get_varchar2: ' || length(apex_session_state.get_varchar2('P20_TEXTAREA')) || ' characters');
    l_value := apex_session_state.get_value('P20_TEXTAREA');
    dbms_output.put_line('get_value:    varchar2_value ' || length(l_value.varchar2_value)
        || ' characters, clob_value ' || nvl(to_char(length(l_value.clob_value)), '(null)'));
    apex_session_state.set_value('P20_SWITCH', true);
    l_value := apex_session_state.get_value('P20_SWITCH');
    dbms_output.put_line('get_value(P20_SWITCH): boolean_value '
        || case l_value.boolean_value when true then 'TRUE' when false then 'FALSE' else '(null)' end);
end;
/
