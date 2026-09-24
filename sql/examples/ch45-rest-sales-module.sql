begin
    ords.enable_schema(
        p_enabled             => true,
        p_schema              => 'ORBIT',
        p_url_mapping_type    => 'BASE_PATH',
        p_url_mapping_pattern => 'orbit',
        p_auto_rest_auth      => true);

    ords.define_module(
        p_module_name    => 'orbit.sales',
        p_base_path      => '/sales/',
        p_items_per_page => 25);

    ords.define_template(
        p_module_name => 'orbit.sales',
        p_pattern     => 'orders/');

    ords.define_handler(
        p_module_name => 'orbit.sales',
        p_pattern     => 'orders/',
        p_method      => 'GET',
        p_source_type => ords.source_type_collection_feed,
        p_source      => q'[
            select order_number, order_date, status, order_total
              from orb_orders
             order by order_date desc, order_number desc]');

    ords.define_template(
        p_module_name => 'orbit.sales',
        p_pattern     => 'orders/:order_number');

    ords.define_handler(
        p_module_name => 'orbit.sales',
        p_pattern     => 'orders/:order_number',
        p_method      => 'GET',
        p_source_type => ords.source_type_collection_item,
        p_source      => q'[
            select o.order_number, o.order_date, o.status, o.order_total,
                   o.discount_pct, c.customer_name
              from orb_orders o
              join orb_customers c on c.customer_id = o.customer_id
             where o.order_number = :order_number]');

    commit;
end;
