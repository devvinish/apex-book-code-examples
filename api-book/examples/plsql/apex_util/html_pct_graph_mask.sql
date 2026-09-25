begin
    dbms_output.put_line(replace(apex_util.html_pct_graph_mask(25), '><', '>' || chr(10) || '<'));
end;
/
