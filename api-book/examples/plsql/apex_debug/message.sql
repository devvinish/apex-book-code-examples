-- @session app=200 page=20
begin
    apex_debug.enable(p_level => apex_debug.c_log_level_info);   -- like DEBUG=YES
    apex_debug.info('Start');
    -- also write the messages to DBMS_OUTPUT: handy in scripts and tests
    apex_debug.enable_dbms_output(p_prefix => '[debug] ');

    apex_debug.error('Order %s: payment failed (%s)', 'ORD-10042', 'card declined');
    apex_debug.warn('Stock of %0 below %1', 'TNT-1002', 5);
    apex_debug.info('Recalculating %s lines, forced: %s', 3, apex_debug.tochar(true));
    apex_debug.message(p_message => 'Total: %s', p0 => to_char(1047.30), p_level => apex_debug.c_log_level_info);
    apex_debug.trace('Line %s: %s', 1, 'TNT-1002');            -- level 6: below the enabled level
    apex_debug.enter('orb_orders_pkg.recalc', 'p_order_id', 42);  -- level 5: not logged either

    apex_debug.disable_dbms_output;
    apex_debug.log_long_message(p_message => rpad('x', 5000, 'x'), p_level => apex_debug.c_log_level_info);
    apex_debug.log_page_session_state(p_page_id => 20, p_level => apex_debug.c_log_level_info);
    dbms_output.put_line('last message ID: ' || case when apex_debug.get_last_message_id > 0 then 'set' end);
    dbms_output.put_line('page view ID:    ' || case when apex_debug.get_page_view_id > 0 then 'set' end);
end;
/
