begin
    apex_escape.set_html_escaping_mode(p_mode => 'B');     -- basic: & < > " only
    dbms_output.put_line('basic:    ' || apex_escape.html('It''s a/b <tent>'));
    apex_escape.set_html_escaping_mode(p_mode => 'E');     -- extended (the default): also ' and /
    dbms_output.put_line('extended: ' || apex_escape.html('It''s a/b <tent>'));
end;
/
