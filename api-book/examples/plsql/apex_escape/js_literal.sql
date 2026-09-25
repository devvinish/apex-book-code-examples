begin
    dbms_output.put_line('js_literal:      ' || apex_escape.js_literal('It''s a "tent"' || chr(10) || '</script>'));
    dbms_output.put_line('js_literal ("):  ' || apex_escape.js_literal('It''s', p_quote => '"'));
    dbms_output.put_line('json:            ' || apex_escape.json('Line 1' || chr(10) || 'Tab' || chr(9) || '"quoted"'));
    dbms_output.put_line('css_selector:    ' || apex_escape.css_selector('order#12:new'));
    dbms_output.put_line('regexp:          ' || apex_escape.regexp('$4.99 (2 pcs)*'));
    dbms_output.put_line('ldap_dn:         ' || apex_escape.ldap_dn('Kim, Linda+Admin'));
    dbms_output.put_line('ldap_filter:     ' || apex_escape.ldap_search_filter('Linda*(Kim)'));
end;
/
