-- @session app=200 page=1
declare
    l_page htp.htbuf_arr;
    l_rows integer := 999;
    l_name owa.vc_arr;
    l_val  owa.vc_arr;
begin
    -- SQL*Plus has no web request; set one up the way ORDS does
    l_name(1) := 'REQUEST_CHARSET'; l_val(1) := 'AL32UTF8';
    owa.init_cgi_env(1, l_name, l_val);
    htp.init;

    -- What an Ajax Callback process does: write straight to the HTTP response (HTP)
    apex_json.initialize_output(p_indent => 1);   -- sends a JSON content-type header
    apex_json.open_object;
    apex_json.write('status', 'ok');
    apex_json.write('count', 3);
    apex_json.close_object;
    apex_json.flush;                   -- push buffered output to HTP

    -- read the HTP buffer back to show what the browser receives
    owa.get_page(l_page, l_rows);
    for i in 1 .. l_rows loop
        dbms_output.put(l_page(i));
    end loop;
    dbms_output.new_line;
end;
/
