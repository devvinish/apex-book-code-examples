-- @session app=200 page=1 user=ADMIN
declare
    function style_id(p_static_id varchar2) return number is
        l_id number;
    begin
        select theme_style_id into l_id from apex_application_theme_styles
         where application_id = 200 and static_id = p_static_id;
        return l_id;
    end;
    procedure show is
        l_current varchar2(100);
    begin
        select name into l_current from apex_application_theme_styles
         where application_id = 200 and is_current = 'Yes';
        dbms_output.put_line('current style: ' || l_current);
    end;
begin
    show;
    apex_theme.set_current_style(p_application_id => 200, p_theme_number => 42, p_id => style_id('vita-slate'));
    apex_theme.disable_user_style(p_application_id => 200, p_theme_number => 42);
    show;
    apex_theme.set_current_style(p_application_id => 200, p_theme_number => 42, p_id => style_id('iris'));   -- back
    apex_theme.enable_user_style(p_application_id => 200, p_theme_number => 42);
    show;
end;
/
