// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const orders = apex.model.get("orbitOrders");
const id = orders.insertNewRecord(null, orders.getRecord("2282"));      // after the first record
console.log("new id:", id, "- STATUS:", orders.getRecordValue(id, "STATUS"), "- at index", orders.indexOf(orders.getRecord(id)));
orders.setRecordValue(id, "CUSTOMER", "Summit Outfitters");
const copies = orders.copyRecords([orders.getRecord("2277")], null, null);   // at the beginning
console.log("copy:", copies, orders.getRecordValue(copies[0], "ORDER_NUMBER"));
orders.moveRecords([orders.getRecord("2280")], null, orders.recordAt(orders.getTotalRecords() - 1));
console.log("order:", (() => { const ids = []; orders.forEach((r, i, rid) => ids.push(rid)); return ids.join(" "); })());
console.log("deleted:", orders.deleteRecords([orders.getRecord("2279")]), "- still there:", !!orders.getRecord("2279"),
            "- deleted flag:", orders.getRecordMetadata("2279").deleted);
