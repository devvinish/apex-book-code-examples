declare
    l_list apex_t_varchar2 := apex_t_varchar2();
    l_nums apex_t_number   := apex_t_number();
begin
    apex_string.push(l_list, 'Tents');
    apex_string.push(l_list, apex_t_varchar2('Stoves', 'Lanterns', 'Tarps'));   -- a whole table
    apex_string.push(l_nums, 2282);
    dbms_output.put_line('list:     ' || apex_string.join(l_list, ', ') || ' - numbers: ' || l_nums.count);
    dbms_output.put_line('index_of: ' || apex_string.index_of(l_list, 'Lanterns') || ', missing: ' || apex_string.index_of(l_list, 'Axes'));
    dbms_output.put_line('grep:     ' || apex_string.join(apex_string.grep(l_list, '^T.*'), ', '));
    dbms_output.put_line('grep i:   ' || apex_string.join(apex_string.grep(l_list, '^.*S$', 'i'), ', '));
    dbms_output.put_line('shuffle:  ' || apex_string.shuffle(l_list).count || ' elements in random order');
    dbms_output.put_line('initials: ' || apex_string.get_initials('Wildflower Travel Co.') || ', '
        || apex_string.get_initials('Matthew Jones', 1));
end;
/
