-- @session app=200 page=1
begin
    -- text messages of the application (Shared Components > Text Messages), in the session's language ...
    dbms_output.put_line(apex_lang.get_message('ORDER_DATE'));
    -- ... or another one; p_params are name/value pairs for the placeholders (%0 has the name 0)
    dbms_output.put_line(apex_lang.get_message(p_name => 'ORDER_DATE', p_lang => 'de'));
    dbms_output.put_line(apex_lang.get_message(p_name => 'ORBIT_DISCOUNT_APPROVAL', p_params => apex_t_varchar2('0', '20')));
    dbms_output.put_line('[' || apex_lang.get_message('NO_SUCH_MESSAGE') || ']');   -- the name itself

    -- a string of the translation repository, in the session's language
    dbms_output.put_line(apex_lang.lang(p_primary_text_string => 'Orders over %0 need approval', p0 => '$5,000'));
end;
/
