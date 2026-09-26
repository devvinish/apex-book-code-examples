declare
    l_js varchar2(4000);
begin
    l_js := '{' || apex_javascript.add_attribute('orderId', 2282)
                || apex_javascript.add_attribute('customer', 'Wildflower "Travel" Co.')
                || apex_javascript.add_attribute('express', true)
                || apex_javascript.add_attribute('note', cast(null as varchar2))       -- omitted: null
                || apex_javascript.add_attribute('total', 463.21, p_add_comma => false) || '}';
    dbms_output.put_line(l_js);
    dbms_output.put_line('[' || apex_javascript.add_value('Tents') || apex_javascript.add_value(42, false) || ']');
    dbms_output.put_line('escape: ' || apex_javascript.escape('It''s "OK"'));
end;
/
