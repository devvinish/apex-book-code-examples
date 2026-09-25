begin
    apex_json.initialize_clob_output(p_indent => 1);
    apex_json.open_object;
    apex_json.write('placed',   timestamp '2026-03-14 09:30:00');
    apex_json.write('shipped',  timestamp '2026-03-15 16:45:12 +05:30');
    apex_json.write('due',      date '2026-03-20', p_format => 'DD.MM.YYYY');
    apex_json.write('qtys',     apex_t_number(2, 1, 4));
    apex_json.write('label',    apex_util.clob_to_blob('ORBIT'));           -- BLOB -> Base64
    apex_json.write('location', sdo_geometry(2001, 4326,
                                   sdo_point_type(-104.9903, 39.7392, null), null, null));
    apex_json.write('dims',     xmltype('<dims><w>210</w><h>130</h></dims>'));
    apex_json.close_object;
    dbms_output.put_line(apex_json.get_clob_output(p_free => true));
end;
/
