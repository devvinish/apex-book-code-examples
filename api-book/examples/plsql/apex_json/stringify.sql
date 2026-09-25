begin
    dbms_output.put_line(apex_json.stringify('Tent "Ridge"' || chr(10) || 'Ultralight'));
    dbms_output.put_line(apex_json.stringify(249.5));
    dbms_output.put_line(apex_json.stringify(date '2026-03-14'));
    dbms_output.put_line(apex_json.stringify(timestamp '2026-03-14 09:30:00.5 +05:30'));
    dbms_output.put_line(apex_json.stringify(true));
    dbms_output.put_line(apex_json.to_member_name('unit price'));
    dbms_output.put_line(apex_json.to_member_name('sku'));
end;
/
