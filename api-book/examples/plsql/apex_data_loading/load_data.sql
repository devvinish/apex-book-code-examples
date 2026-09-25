-- @session app=200 page=1
declare
    l_old    apex_t_number;
    l_result apex_data_loading.t_data_load_result;
begin
    select unit_price bulk collect into l_old from orb_products
     where sku in ('TNT-1001', 'TNT-1002') order by sku;

    -- the lab's Data Load Definition "price-list" merges SKU and UNIT_PRICE into ORB_PRODUCTS
    l_result := apex_data_loading.load_data(
                    p_static_id    => 'price-list',
                    p_data_to_load => 'SKU,UNIT_PRICE'  || chr(10) ||
                                      'TNT-1001,249.99' || chr(10) ||
                                      'TNT-1002,284.99');
    dbms_output.put_line('processed: ' || l_result.processed_rows || ', errors: ' || l_result.error_rows);

    for r in (select sku, unit_price from orb_products where sku in ('TNT-1001', 'TNT-1002') order by sku) loop
        dbms_output.put_line(r.sku || ' now ' || r.unit_price);
    end loop;

    -- put the old prices back
    l_result := apex_data_loading.load_data(
                    p_static_id    => 'price-list',
                    p_data_to_load => 'SKU,UNIT_PRICE' || chr(10) || 'TNT-1001,' || l_old(1)
                                                       || chr(10) || 'TNT-1002,' || l_old(2));
    dbms_output.put_line('restored: ' || l_result.processed_rows);

    dbms_output.put_line(json_object_t.parse(apex_data_loading.get_file_profile(p_static_id => 'price-list')).to_clob);
end;
/
