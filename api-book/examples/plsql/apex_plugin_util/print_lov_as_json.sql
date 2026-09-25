-- @session app=200 page=20
declare
    l_page htp.htbuf_arr;
    l_rows integer := 999;
    l_name owa.vc_arr;
    l_val  owa.vc_arr;
begin
    l_name(1) := 'REQUEST_CHARSET'; l_val(1) := 'AL32UTF8';
    owa.init_cgi_env(1, l_name, l_val);
    htp.init;

    -- in the Ajax callback of an item plug-in: answer with the LOV as JSON
    apex_plugin_util.print_lov_as_json(
        p_sql_statement  => 'select category_name as d, category_id as r from orb_categories
                              where parent_category_id is null and category_id <= 3 order by 2',
        p_component_name => 'P20_CATEGORY',
        p_escape         => true);
    owa.get_page(l_page, l_rows);
    for i in 1 .. l_rows loop
        if l_page(i) like 'Content-Type%' or l_page(i) not like '%:%' or l_page(i) like '%"d"%' then
            dbms_output.put(l_page(i));            -- the content type and the JSON, not the other headers
        end if;
    end loop;
    dbms_output.new_line;
end;
/
