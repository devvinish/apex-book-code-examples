-- @session app=200 page=1
declare
    procedure list(p_label varchar2) is
        l_list varchar2(400);
    begin
        select listagg(n, ' ') within group (order by n) into l_list
          from (select column_value || '(' || apex_collection.collection_member_count(column_value) || ')' as n
                  from table(apex_t_varchar2('A', 'B', 'C'))
                 where apex_collection.collection_exists(column_value));
        dbms_output.put_line(rpad(p_label, 20) || nvl(l_list, '-'));
    end;
begin
    for c in (select column_value as name from table(apex_t_varchar2('A', 'B', 'C'))) loop
        apex_collection.create_collection(c.name);
        apex_collection.add_member(c.name, p_c001 => 'x');
    end loop;
    list('created');
    apex_collection.truncate_collection('A');       list('A truncated');
    apex_collection.delete_collection('B');         list('B deleted');
    apex_collection.create_collection('C', p_truncate_if_exists => 'YES');
    list('C re-created');
    apex_collection.delete_all_collections;         list('all deleted');

    begin
        apex_collection.create_collection('A');
        apex_collection.create_collection('A');
    exception when others then
        dbms_output.put_line('twice: ' || regexp_replace(sqlerrm, '^ORA-\d+: '));
    end;
    apex_collection.delete_all_collections_session;
    apex_collection.reset_collection_changed_all;
end;
/
