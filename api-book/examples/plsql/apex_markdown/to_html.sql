declare
    l_html clob;
begin
    l_html := apex_markdown.to_html(
        p_markdown => '## Order ORD-12283' || chr(10) || chr(10)
                   || '- **Status:** shipped' || chr(10)
                   || '- Track it [here](https://orbit-outfitters.example/track)' || chr(10) || chr(10)
                   || '<script>alert(1)</script>',
        p_extra_link_attributes => apex_t_varchar2('target', '_blank'));
    dbms_output.put_line(l_html);
end;
/
