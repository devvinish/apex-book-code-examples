declare
    l_ids   apex_t_number;
    l_words apex_t_varchar2;
    l_parts apex_t_clob;
begin
    l_words := apex_string.split('tent,stove;lamp', '[,;]');         -- a regular expression
    dbms_output.put_line('regexp split: ' || apex_string.join(l_words, ' | '));
    l_words := apex_string.split('a:b:c:d', ':', p_limit => 2);
    dbms_output.put_line('limit 2:      ' || apex_string.join(l_words, ' | '));
    l_ids := apex_string.split_numbers('2282:2280:2279', ':');
    dbms_output.put_line('numbers:      ' || l_ids.count || ', sum ' || (l_ids(1) + l_ids(2) + l_ids(3)));
    l_parts := apex_string.split_clobs(to_clob('line one' || chr(10) || 'line two'));
    dbms_output.put_line('clobs:        ' || l_parts.count || ', joined: ' || replace(apex_string.join_clobs(l_parts, ' / '), chr(10)));
    dbms_output.put_line('join_clob:    ' || apex_string.join_clob(apex_t_varchar2('ORD-12283', 'ORD-12280'), ', '));
end;
/
