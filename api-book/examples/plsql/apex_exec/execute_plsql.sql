-- @session app=200 page=1
declare
    l_params apex_exec.t_parameters;
begin
    apex_exec.add_parameter(l_params, 'STATUS', 'SHIPPED');
    apex_exec.add_parameter(l_params, 'SINCE',  date '2026-01-01');
    apex_exec.add_parameter(l_params, 'CNT',    0);          -- OUT binds need a parameter too
    apex_exec.add_parameter(l_params, 'TOTAL',  0);

    apex_exec.execute_plsql(
        p_plsql_code     => 'begin
                                select count(*), sum(order_total) into :CNT, :TOTAL
                                  from orb_orders where status = :STATUS and order_date >= :SINCE;
                            end;',
        p_sql_parameters => l_params);

    -- in 26.1 the values come back as strings: read them with get_parameter_varchar2
    dbms_output.put_line('orders: ' || apex_exec.get_parameter_varchar2(l_params, 'CNT'));
    dbms_output.put_line('total:  ' || apex_exec.get_parameter_varchar2(l_params, 'TOTAL'));
    dbms_output.put_line('as number: [' || apex_exec.get_parameter_number(l_params, 'TOTAL') || ']');
end;
/
