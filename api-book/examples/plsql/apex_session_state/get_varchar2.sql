-- @session app=200 page=20 user=ADMIN
-- @expect-error
begin
    apex_session_state.set_value('P20_TEXT', 'Trailblazer 2-Person Tent');
    apex_session_state.set_value('P20_NUMBER', '1,249.50');          -- in the item's format mask
    apex_session_state.set_value('P20_DATE', '23-SEP-2026');         -- in the session's date format
    apex_session_state.set_value('P20_SWITCH', true);                -- BOOLEAN
    dbms_output.put_line('get_varchar2(P20_TEXT):  ' || apex_session_state.get_varchar2('P20_TEXT'));
    dbms_output.put_line('get_number(P20_NUMBER):  ' || apex_session_state.get_number('P20_NUMBER'));
    dbms_output.put_line('get_timestamp(P20_DATE): ' || to_char(apex_session_state.get_timestamp('P20_DATE'), 'YYYY-MM-DD HH24:MI'));
    dbms_output.put_line('get_boolean(P20_SWITCH): ' || case apex_session_state.get_boolean('P20_SWITCH') when true then 'TRUE' else 'FALSE' end);
    apex_session_state.set_value('P20_NUMBER', 1249.5);              -- a NUMBER is stored as is...
    dbms_output.put_line('v(P20_NUMBER):           ' || v('P20_NUMBER'));
    dbms_output.put_line('get_number(P20_NUMBER):  ' || apex_session_state.get_number('P20_NUMBER'));   -- ...and fails
exception
    when value_error then dbms_output.put_line('get_number: ' || sqlerrm);
end;
/
