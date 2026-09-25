-- @session app=200 page=1
declare
    l_names apex_application_global.vc_arr2;
    l_vals  apex_application_global.vc_arr2;
begin
    -- columns go to c001, c002, ... in order
    apex_collection.create_collection_from_query(
        p_collection_name    => 'ORDERS',
        p_query              => q'~select order_number, status from orb_orders
                                    where status = 'SHIPPED' order by order_id~',
        p_generate_md5       => 'YES');

    -- ...2: five numbers (n001-n005), five dates (d001-d005), then strings (c001...)
    apex_collection.create_collection_from_query2(
        p_collection_name    => 'ORDER_TOTALS',
        p_query              => q'~select order_id, order_total, null, null, null,
                                          order_date, null, null, null, null, order_number
                                     from orb_orders where status = 'SHIPPED' order by order_id~');

    -- _b: bulk fetch, faster, no MD5; binds by name
    l_names(1) := 'STATUS'; l_vals(1) := 'NEW';
    apex_collection.create_collection_from_query_b(
        p_collection_name    => 'NEW_ORDERS',
        p_query              => 'select order_number, channel from orb_orders where status = :status',
        p_names              => l_names,
        p_values             => l_vals,
        p_max_row_count      => 5);

    -- b2: bulk with numbers and dates first; p_truncate_if_exists replaces an existing one
    apex_collection.create_collection_from_queryb2(
        p_collection_name    => 'ORDER_TOTALS',
        p_query              => q'~select order_id, order_total, null, null, null,
                                          order_date, null, null, null, null, order_number
                                     from orb_orders where status = 'DELIVERED'~',
        p_truncate_if_exists => 'YES');
end;
/

select collection_name, count(*) as members, min(c001) as first_c001,
       max(n002) as max_n002, count(md5_original) as with_md5
  from apex_collections
 group by collection_name
 order by collection_name;
