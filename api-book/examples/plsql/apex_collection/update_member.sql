-- @session app=200 page=1
begin
    apex_collection.create_collection_from_query(
        p_collection_name => 'CART',
        p_query           => q'~select sku, product_name, 1 from orb_products
                                  where sku in ('TNT-1002', 'SLP-1002', 'KIT-1003') order by sku~',
        p_generate_md5    => 'YES');
    apex_collection.reset_collection_changed('CART');

    -- replaces all attributes of member 1: the ones not passed become null
    apex_collection.update_member(p_collection_name => 'CART', p_seq => 1,
                                  p_c001 => 'KIT-1003', p_c002 => 'Titanium Pot 750 ml', p_n001 => 3);

    -- sets a single attribute, keeping the others
    apex_collection.update_member_attribute(p_collection_name => 'CART', p_seq => 2,
                                            p_attr_number => 3, p_attr_value => '2');
    apex_collection.update_member_attribute(p_collection_name => 'CART', p_seq => 2,
                                            p_attr_number => 1, p_number_value => 5);
    apex_collection.update_member_attribute(p_collection_name => 'CART', p_seq => 2,
                                            p_attr_number => 1, p_date_value => date '2026-04-01');
    apex_collection.update_member_attribute(p_collection_name => 'CART', p_seq => 2,
                                            p_clob_number => 1, p_clob_value => 'Gift wrap, please.');

    dbms_output.put_line('changed: ' ||
        case when apex_collection.collection_has_changed('CART') then 'yes' else 'no' end);
end;
/

select seq_id, c001, c002, c003, n001, d001, dbms_lob.substr(clob001, 30, 1) as clob001,
       case when md5_original = apex_collection.get_member_md5('CART', seq_id)
            then 'same' else 'changed' end as md5
  from apex_collections
 where collection_name = 'CART'
 order by seq_id;
