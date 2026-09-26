declare
    l_order varchar2(4000) := q'~{
      "orderNumber": "ORD-10042",
      "orderDate": "2026-03-14T09:30:00Z",
      "paid": true,
      "customer": { "name": "Alpine Outfitters", "tier": "GOLD" },
      "items": [
        { "sku": "TNT-2P",  "qty": 2, "price": 249.00 },
        { "sku": "BAG-0F",  "qty": 1, "price": 389.50 },
        { "sku": "LMP-HD",  "qty": 4, "price": 39.95 } ],
      "tags": ["priority", "gift"]
    }~';
begin
    apex_json.parse(l_order);   -- fills the package variable apex_json.g_values

    dbms_output.put_line('order:    ' || apex_json.get_varchar2('orderNumber'));
    dbms_output.put_line('date:     ' || to_char(apex_json.get_date('orderDate'), 'DD-MON-YYYY HH24:MI'));
    dbms_output.put_line('paid:     ' || case when apex_json.get_boolean('paid') then 'yes' else 'no' end);
    dbms_output.put_line('customer: ' || apex_json.get_varchar2('customer.name'));
    dbms_output.put_line('items:    ' || apex_json.get_count('items'));

    for i in 1 .. apex_json.get_count('items') loop
        dbms_output.put_line(apex_json.get_varchar2('items[%d].sku', i) || ' x '
            || apex_json.get_number('items[%d].qty', i) || ' @ '
            || apex_json.get_number('items[%d].price', i));
    end loop;

    dbms_output.put_line('tags:     ' || apex_string.join(apex_json.get_t_varchar2('tags'), ', '));
    dbms_output.put_line('members:  ' || apex_string.join(apex_json.get_members('customer'), ', '));
    dbms_output.put_line('coupon?   ' || case when apex_json.does_exist('coupon') then 'yes' else 'no' end);
    dbms_output.put_line('discount: ' || apex_json.get_number('discount', p_default => 0));
end;
/
