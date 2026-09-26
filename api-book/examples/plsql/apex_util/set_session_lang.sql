-- @session app=200 page=1 user=ADMIN
begin
    dbms_output.put_line('lang ' || nvl(apex_util.get_session_lang, '(null)') || ', territory ' || nvl(apex_util.get_session_territory, '(null)')
        || ', time zone ' || nvl(apex_util.get_session_time_zone, '(null)'));
    apex_util.set_session_lang(p_lang => 'de');
    apex_util.set_session_territory(p_territory => 'GERMANY');
    apex_util.set_session_time_zone(p_time_zone => 'Europe/Berlin');
    dbms_output.put_line('lang ' || apex_util.get_session_lang || ', territory ' || apex_util.get_session_territory
        || ', time zone ' || apex_util.get_session_time_zone);
    apex_util.set_session_lifetime_seconds(p_seconds => 8 * 3600);   -- this session: at most 8 hours
    apex_util.set_session_max_idle_seconds(p_seconds => 1800);       -- and 30 minutes idle
    dbms_output.put_line('session limits set');
end;
/
