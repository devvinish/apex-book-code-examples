-- @session app=200 page=1
declare
    l_seq  number;
    l_skus apex_application_global.vc_arr2;
    l_qtys apex_application_global.n_arr;
begin
    apex_collection.create_or_truncate_collection(p_collection_name => 'CART');

    -- one member: c001..c050 strings, n001..n005 numbers, d001..d005 dates
    apex_collection.add_member(
        p_collection_name => 'CART',
        p_c001            => 'TNT-1002',
        p_c002            => 'Trailblazer 2-Person Tent',
        p_n001            => 1,
        p_n002            => 274.99,
        p_d001            => date '2026-03-14');

    -- the function returns the new member's sequence ID
    l_seq := apex_collection.add_member(p_collection_name => 'cart',   -- names are not case-sensitive
                                        p_c001 => 'SLP-1002', p_c002 => 'Nightfall 0° Down Bag',
                                        p_n001 => 2, p_n002 => 389.50);
    dbms_output.put_line('new member: ' || l_seq);

    -- many members at once, one array per attribute
    l_skus(1) := 'KIT-1003'; l_qtys(1) := 4;
    l_skus(2) := 'KIT-1008'; l_qtys(2) := 6;
    apex_collection.add_members(p_collection_name => 'CART', p_c001 => l_skus, p_n001 => l_qtys);

    dbms_output.put_line('exists: ' || case when apex_collection.collection_exists('CART') then 'yes' else 'no' end
                      || ', members: ' || apex_collection.collection_member_count('CART'));
end;
/

select seq_id, c001, c002, n001, n002, d001
  from apex_collections
 where collection_name = 'CART'
 order by seq_id;
