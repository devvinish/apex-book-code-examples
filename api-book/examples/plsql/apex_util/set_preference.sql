-- @session app=200 page=1 user=ADMIN
begin
    apex_util.set_preference(p_preference => 'ORBIT_DEFAULT_STORE', p_value => '7', p_user => 'ADMIN');
    dbms_output.put_line('get_preference: ' || apex_util.get_preference(p_preference => 'ORBIT_DEFAULT_STORE', p_user => 'ADMIN'));
    apex_util.remove_preference(p_preference => 'ORBIT_DEFAULT_STORE', p_user => 'ADMIN');
    dbms_output.put_line('after remove:   ' || nvl(apex_util.get_preference('ORBIT_DEFAULT_STORE', 'ADMIN'), '(null)'));
    apex_util.remove_sort_preferences(p_user => 'ADMIN');   -- the user's report column sorting
end;
/
