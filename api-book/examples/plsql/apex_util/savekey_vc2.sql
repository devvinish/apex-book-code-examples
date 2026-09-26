begin
    dbms_output.put_line('savekey_vc2: ' || apex_util.savekey_vc2('ORBIT') || ', keyval_vc2: ' || apex_util.keyval_vc2);
    dbms_output.put_line('savekey_num: ' || apex_util.savekey_num(2282) || ', keyval_num: ' || apex_util.keyval_num);
end;
/
