-- @session app=200 page=1 user=ADMIN
declare
    l_page  htp.htbuf_arr;
    l_lines number := 1000;
    l_html  varchar2(32767);
begin
    owa.init_cgi_env(0, owa.vc_arr(), owa.vc_arr());         -- an HTP buffer outside a web request
    apex_application.help(p_flow_id => 200, p_flow_step_id => 2, p_show_regions => 'NO');
    owa.get_page(l_page, l_lines);
    for i in 1 .. l_lines loop
        if l_page(i) not like 'Content-%' then                   -- skip the HTTP headers
            l_html := l_html || l_page(i);
        end if;
    end loop;
    for r in (select column_value as para from apex_string.split(l_html, '</p>') where trim(column_value) is not null) loop
        dbms_output.put_line(substr(trim(r.para), 1, 88) || '...');     -- the start of each paragraph
    end loop;
end;
/
