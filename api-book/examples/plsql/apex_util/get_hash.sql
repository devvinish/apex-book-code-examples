-- @session app=200 page=1 user=ADMIN
declare
    l_hash varchar2(4000);
begin
    l_hash := apex_util.get_hash(apex_t_varchar2('ORBIT_DEMO', 'reset-password', to_char(sysdate, 'YYYY-MM-DD')));
    dbms_output.put_line('hash: ' || substr(l_hash, 1, 20) || '... (' || length(l_hash) || ' characters)');
    dbms_output.put_line('same input, same hash: ' || case when l_hash = apex_util.get_hash(
        apex_t_varchar2('ORBIT_DEMO', 'reset-password', to_char(sysdate, 'YYYY-MM-DD'))) then 'yes' end);
    dbms_output.put_line('salted per session:    ' || case when l_hash = apex_util.get_hash(
        apex_t_varchar2('ORBIT_DEMO', 'reset-password', to_char(sysdate, 'YYYY-MM-DD')), p_salted => false) then 'no' else 'yes' end);
end;
/
