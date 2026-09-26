-- @session app=200 page=1 user=ADMIN
begin
    apex_util.set_session_screen_reader_on;
    apex_util.set_session_high_contrast_on;
    dbms_output.put_line('screen reader: ' || apex_util.is_screen_reader_session_yn
        || ', high contrast: ' || apex_util.is_high_contrast_session_yn);
    dbms_output.put_line('toggle: ' || regexp_replace(apex_util.get_screen_reader_mode_toggle, 'session=\d+', 'session=...'));
    apex_util.set_session_screen_reader_off;
    apex_util.set_session_high_contrast_off;
    dbms_output.put_line('screen reader: ' || case when apex_util.is_screen_reader_session then 'on' else 'off' end
        || ', high contrast: ' || case when apex_util.is_high_contrast_session then 'on' else 'off' end);
    dbms_output.put_line('toggle: ' || regexp_replace(apex_util.get_high_contrast_mode_toggle(p_on_message => 'High contrast'), 'session=\d+', 'session=...'));
end;
/
