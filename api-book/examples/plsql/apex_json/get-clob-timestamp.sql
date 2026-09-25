declare
    l_json clob;
begin
    l_json := '{"note":"';
    for i in 1 .. 20 loop
        l_json := l_json || rpad('x', 2000, 'x');           -- 40,000 characters
    end loop;
    l_json := l_json || '","shippedAt":"2026-03-15T16:45:12Z",'
                     || '"deliveredAt":"2026-03-18T11:20:05.250+05:30",'
                     || '"placed":"14.03.2026"}';
    apex_json.parse(l_json);

    dbms_output.put_line('note length:  ' || dbms_lob.getlength(apex_json.get_clob('note')));
    dbms_output.put_line('shipped:      ' || to_char(apex_json.get_timestamp('shippedAt'),
                                                     'DD-MON-YYYY HH24:MI:SS'));
    dbms_output.put_line('shipped IST:  ' || to_char(apex_json.get_timestamp('shippedAt',
                                                     p_at_time_zone => 'Asia/Kolkata'), 'DD-MON-YYYY HH24:MI:SS'));
    dbms_output.put_line('delivered:    ' || to_char(apex_json.get_timestamp_tz('deliveredAt',
                                                     p_format => apex_json.c_timestamp_iso8601_ff_tzd),
                                                     'DD-MON-YYYY HH24:MI:SS.FF3 TZH:TZM'));
    dbms_output.put_line('placed:       ' || to_char(apex_json.get_date('placed',
                                                     p_format => 'DD.MM.YYYY'), 'DD-MON-YYYY'));
    -- without p_format the offset +05:30 is read as a region name
    dbms_output.put_line('no format:    ' || to_char(apex_json.get_timestamp_tz('deliveredAt')));
exception
    when others then
        dbms_output.put_line('no format:    ' || regexp_replace(sqlerrm, '^ORA-\d+: '));
end;
/
