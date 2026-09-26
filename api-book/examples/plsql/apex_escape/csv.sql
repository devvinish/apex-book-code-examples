begin
    dbms_output.put_line('default:   ' || apex_escape.csv('Tent, "Olive"') || ' | enclosed by ' || apex_escape.get_csv_enclosed_by
        || ', separated by ' || apex_escape.get_csv_separated_by);
    dbms_output.put_line('formula:   ' || apex_escape.csv('=SUM(A1:A9)'));             -- spreadsheet formulas are neutralized
    dbms_output.put_line('strip:     ' || apex_escape.csv('<b>ORD-12283</b>', p_strip_html => true));
    apex_escape.set_csv_parameters(p_enclosed_by => '''', p_separated_by => ';');
    dbms_output.put_line('changed:   ' || apex_escape.csv('Tent; Olive') || ' | separated by ' || apex_escape.get_csv_separated_by);
end;
/
