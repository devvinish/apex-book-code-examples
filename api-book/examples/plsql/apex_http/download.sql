-- @session app=200 page=1
declare
    l_page htp.htbuf_arr;
    l_rows integer := 999;
    l_name owa.vc_arr;
    l_val  owa.vc_arr;
    l_text varchar2(32767);
    l_csv  clob := 'sku,qty' || chr(10) || 'TNT-1002,2';
begin
    l_name(1) := 'REQUEST_CHARSET'; l_val(1) := 'AL32UTF8';     -- a web request, as ORDS sets it up
    owa.init_cgi_env(1, l_name, l_val);
    htp.init;

    -- in an Ajax callback or a Before Header process
    begin
        apex_http.download(p_clob         => l_csv,
                           p_content_type => 'text/csv',
                           p_filename     => 'order.csv');
    exception
        when apex_application.e_stop_apex_engine then null;   -- download stops the engine
    end;

    owa.get_page(l_page, l_rows);                          -- the headers the browser receives
    for i in 1 .. l_rows loop
        l_text := l_text || l_page(i);
    end loop;
    for h in (select column_value as line from table(apex_string.split(l_text, chr(10)))
               where column_value like 'Content-%' and column_value not like 'Content-Security%') loop
        dbms_output.put_line(h.line);
    end loop;
end;
/
