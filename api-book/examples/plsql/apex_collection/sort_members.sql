-- @session app=200 page=1
declare
    procedure show(p_label varchar2) is
        l_list varchar2(400);
    begin
        select listagg(seq_id || ':' || c001, ' ') within group (order by seq_id) into l_list
          from apex_collections where collection_name = 'CART';
        dbms_output.put_line(rpad(p_label, 16) || l_list);
    end;
begin
    apex_collection.create_collection_from_query(
        p_collection_name => 'CART',
        p_query           => q'~select sku from orb_products
                                  where sku in ('TNT-1002', 'SLP-1002', 'KIT-1003', 'KIT-1008', 'FUR-1001')
                                  order by product_id~');
    show('created');
    apex_collection.move_member_up('CART', p_seq => 3);    show('3 up (+1)');
    apex_collection.move_member_down('CART', p_seq => 3);  show('3 down (-1)');
    apex_collection.sort_members('CART', p_sort_on_column_number => 1);  show('sorted by c001');
    apex_collection.delete_member('CART', p_seq => 2);     show('2 deleted');
    apex_collection.resequence_collection('CART');         show('resequenced');
    apex_collection.delete_members('CART', p_attr_number => 1, p_attr_value => 'TNT-1002');
    show('TNT deleted');
end;
/
