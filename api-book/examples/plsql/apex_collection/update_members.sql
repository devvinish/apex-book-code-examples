-- @session app=200 page=1
declare
    l_seq  apex_application_global.vc_arr2;
    l_sku  apex_application_global.vc_arr2;
    l_qty  apex_application_global.vc_arr2;
begin
    apex_collection.create_collection_from_query(
        p_collection_name => 'CART',
        p_query           => q'~select sku, '1' from orb_products
                                  where sku in ('TNT-1002', 'SLP-1002', 'KIT-1003') order by sku~');

    -- update members 1 and 3 from arrays, as a tabular form would post them
    l_seq(1) := 1; l_sku(1) := 'KIT-1003'; l_qty(1) := '4';
    l_seq(2) := 3; l_sku(2) := 'TNT-1002'; l_qty(2) := '2';
    apex_collection.update_members(p_collection_name => 'CART', p_seq => l_seq,
                                   p_c001 => l_sku, p_c002 => l_qty);
end;
/

select seq_id, c001, c002 from apex_collections where collection_name = 'CART' order by seq_id;

declare
    l_seq  apex_application_global.vc_arr2;
    l_sku  apex_application_global.vc_arr2;
    l_qty  apex_application_global.vc_arr2;
begin
    -- merge: member 1 updated, 2 removed (its quantity c002 is the null value 0),
    -- 3 deleted (not in the arrays), and 4 added (a new sequence ID)
    l_seq(1) := 1; l_sku(1) := 'KIT-1003'; l_qty(1) := '5';
    l_seq(2) := 2; l_sku(2) := 'SLP-1002'; l_qty(2) := '0';
    l_seq(3) := 4; l_sku(3) := 'KIT-1008'; l_qty(3) := '6';
    apex_collection.merge_members(p_collection_name => 'CART', p_seq => l_seq,
                                  p_c001 => l_sku, p_c002 => l_qty,
                                  p_null_index => 2, p_null_value => '0');
end;
/

select seq_id, c001, c002 from apex_collections where collection_name = 'CART' order by seq_id;
