-- @session app=200 page=20
declare
    l_item   apex_plugin.t_item;
    l_plugin apex_plugin.t_plugin;
    l_param  apex_plugin.t_item_render_param;
    l_result apex_plugin.t_item_render_result;
    l_page   htp.htbuf_arr;
    l_rows   integer := 999;
    l_name   owa.vc_arr;
    l_val    owa.vc_arr;

    -- the render procedure of an item type plug-in: a star rating as radio buttons
    procedure render_rating(p_item in apex_plugin.t_item, p_plugin in apex_plugin.t_plugin,
                            p_param in apex_plugin.t_item_render_param,
                            p_result in out nocopy apex_plugin.t_item_render_result) is
        l_max number := p_item.attributes.get_number('max_stars', p_default_value => 5);
    begin
        if p_param.is_readonly then
            apex_plugin_util.print_hidden(p_item_name => p_item.name, p_value => p_param.value);
            sys.htp.p(apex_escape.html(p_param.value) || ' of ' || l_max);
            return;
        end if;
        sys.htp.p('<div ' || apex_plugin_util.get_element_attributes(p_item, p_item.name, 'orb-rating') || '>');
        for i in 1 .. l_max loop
            sys.htp.p('<input type="radio" name="' || apex_plugin.get_input_name_for_item || '" value="' || i || '"'
                      || case when i = p_param.value then ' checked' end || '>');
        end loop;
        sys.htp.p('</div>');
        p_result.is_navigable := true;
    end;
begin
    l_name(1) := 'REQUEST_CHARSET'; l_val(1) := 'AL32UTF8';          -- a web request, as ORDS sets it up
    owa.init_cgi_env(1, l_name, l_val);
    htp.init;

    -- what APEX passes: the item's properties, the plug-in, and the value
    l_item.name       := 'P20_STAR_RATING';
    l_item.attributes := apex_t_plugin_attributes(apex_t_varchar2('max_stars', '5'));
    l_param.value     := '4';
    render_rating(l_item, l_plugin, l_param, l_result);
    l_param.is_readonly := true;
    render_rating(l_item, l_plugin, l_param, l_result);

    owa.get_page(l_page, l_rows);
    for i in 3 .. l_rows loop                                          -- skip the HTTP headers
        dbms_output.put(l_page(i));
    end loop;
    dbms_output.new_line;
end;
/
