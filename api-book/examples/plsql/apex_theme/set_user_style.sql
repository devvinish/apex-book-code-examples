-- @session app=200 page=1 user=ADMIN
declare
    l_style_id number;
begin
    select theme_style_id into l_style_id
      from apex_application_theme_styles
     where application_id = 200 and static_id = 'vita-dark';
    dbms_output.put_line('user style: ' || nvl(to_char(apex_theme.get_user_style(p_application_id => 200, p_user => 'ADMIN', p_theme_number => 42)), '(none)'));
    apex_theme.set_user_style(p_application_id => 200, p_user => 'ADMIN', p_theme_number => 42, p_id => l_style_id);
    dbms_output.put_line('user style: ' || case when apex_theme.get_user_style(200, 'ADMIN', 42) = l_style_id then 'Vita - Dark' end);
    apex_theme.clear_user_style(p_application_id => 200, p_user => 'ADMIN', p_theme_number => 42);
    dbms_output.put_line('after clear_user_style: ' || nvl(to_char(apex_theme.get_user_style(200, 'ADMIN', 42)), '(none)'));
    apex_theme.clear_all_users_style(p_application_id => 200, p_theme_number => 42);
end;
/
