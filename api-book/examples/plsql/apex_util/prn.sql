-- @session app=200 page=1 user=ADMIN
declare
    l_page  htp.htbuf_arr;
    l_lines number := 100;
begin
    owa.init_cgi_env(0, owa.vc_arr(), owa.vc_arr());
    apex_util.prn(p_clob => to_clob('<p>Order ORD-12283 & shipping</p>'), p_escape => true);
    apex_util.prn(p_clob => to_clob('<p>Order ORD-12283</p>'), p_escape => false);
    owa.get_page(l_page, l_lines);
    for i in 1 .. l_lines loop
        if l_page(i) not like 'Content-%' and trim(l_page(i)) is not null then dbms_output.put_line(l_page(i)); end if;
    end loop;
end;
/
