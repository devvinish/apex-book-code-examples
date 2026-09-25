begin
    -- turn what users type into Oracle Text syntax, for your own CONTAINS queries
    dbms_output.put_line(apex_search.query_expert_search('(tent or shelter) "two person"'));
    dbms_output.put_line(apex_search.query_expert_search('fuzzy-: tnet'));
    dbms_output.put_line(apex_search.query_expert_search('trailblazer^3 tent'));
    dbms_output.put_line(substr(apex_search.query_search_engine('tent shelter'), 1, 120) || '...');
end;
/
