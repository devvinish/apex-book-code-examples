-- Chapter 40: a JSON Relational Duality View of orders, with their customer and lines.
create or replace json relational duality view orb_order_dv as
select json {
         '_id'         : o.order_id,
         'orderNumber' : o.order_number,
         'orderDate'   : o.order_date,
         'status'      : o.status,
         'orderTotal'  : o.order_total  with noupdate,
         'customer'    : (select json {
                                   'customerId' : c.customer_id,
                                   'name'       : c.customer_name,
                                   'city'       : c.city }
                            from orb_customers c with noinsert noupdate nodelete
                           where c.customer_id = o.customer_id),
         'lines'       : [ select json {
                                   'itemId'    : i.order_item_id,
                                   'lineNo'    : i.line_no,
                                   'productId' : i.product_id,
                                   'quantity'  : i.quantity,
                                   'unitPrice' : i.unit_price }
                             from orb_order_items i with insert update delete
                            where i.order_id = o.order_id ] }
  from orb_orders o with update;
