declare
    l_orders sys_refcursor;
begin
    open l_orders for
        select o.order_number as "orderNumber",
               o.status       as "status",
               o.order_total  as "total",
               cursor(select p.sku, i.quantity as "qty"
                        from orb_order_items i
                        join orb_products p on p.product_id = i.product_id
                       where i.order_id = o.order_id
                       order by p.sku) as "items"
          from orb_orders o
         where o.order_id in (1, 2)
         order by o.order_id;

    apex_json.initialize_clob_output(p_indent => 1);
    apex_json.open_object;
    apex_json.write('orders', l_orders);   -- one object per row, nested cursor -> array
    apex_json.close_object;
    dbms_output.put_line(apex_json.get_clob_output(p_free => true));
end;
/
