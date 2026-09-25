declare
    l_input varchar2(200) := 'O''Brien & Sons <script>alert("x")</script>';
begin
    dbms_output.put_line('html:           ' || apex_escape.html(l_input));
    dbms_output.put_line('html_attribute: ' || apex_escape.html_attribute('Tent "Olive" & more'));
    dbms_output.put_line('striphtml:      ' || apex_escape.striphtml('<p>Order <b>ORD-12283</b> shipped</p>'));
    dbms_output.put_line('html_trunc:     ' || apex_escape.html_trunc(rpad('Tent & ', 30, 'x'), 12));
    dbms_output.put_line('allowlist:      ' || apex_escape.html_allowlist('<b>Bold</b> <img src=x onerror=alert(1)> <i>ok</i>'));
    dbms_output.put_line('noop:           ' || apex_escape.noop('<b>as is</b>'));
end;
/
