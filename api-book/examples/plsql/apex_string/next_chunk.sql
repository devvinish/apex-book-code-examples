declare
    l_clob   clob := rpad('x', 20000, 'x');
    l_chunk  varchar2(8191);
    l_offset integer;                                  -- null: start at the beginning
begin
    while apex_string.next_chunk(p_str => l_clob, p_chunk => l_chunk, p_offset => l_offset, p_amount => 8000) loop
        dbms_output.put_line('chunk of ' || length(l_chunk) || ', next offset ' || l_offset);
    end loop;
end;
/
