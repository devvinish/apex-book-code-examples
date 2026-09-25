-- @session app=200 page=1 user=ADMIN
begin
    apex_theme.set_session_style(p_application_id => 200, p_theme_number => 42, p_name => 'redwood-light');
    apex_theme.set_session_style_css(p_theme_number => 42,
        p_css_file_urls => '#APP_FILES#orbit-print.css', p_page_css_classes => 'orbit-print');
    dbms_output.put_line('session style set: the next pages of this session use Redwood Light');
end;
/
