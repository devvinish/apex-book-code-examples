select x.sku, x.qty
  from xmltable('/json/items/row'
         passing apex_json.to_xmltype_sql(
                   '{"items":[{"sku":"TNT-2P","qty":2},{"sku":"BAG-0F","qty":1}]}')
         columns sku varchar2(10) path 'sku',
                 qty number       path 'qty') x;
