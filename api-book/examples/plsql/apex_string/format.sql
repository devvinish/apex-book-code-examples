-- @session app=200 page=1 user=ADMIN
declare
    l_count pls_integer;
begin
    select count(*) into l_count from orb_orders where status = 'SHIPPED';
    dbms_output.put_line(
        apex_string.format(
            p_message => 'User %0 sees %1 shipped orders in application %2.',
            p0        => apex_application.g_user,
            p1        => l_count,
            p2        => apex_application.g_flow_id));
end;
/
