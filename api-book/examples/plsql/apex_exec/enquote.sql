-- @session app=200 page=1
begin
    dbms_output.put_line(apex_exec.enquote_literal(q'~O'Brien's Outfitters~'));
    dbms_output.put_line(apex_exec.enquote_name('ORB_PRODUCTS'));
    dbms_output.put_line(apex_exec.enquote_name('Unit Price'));
    dbms_output.put_line(apex_exec.enquote_name('unit_price', p_for_database => apex_exec.c_database_mysql));
end;
/
