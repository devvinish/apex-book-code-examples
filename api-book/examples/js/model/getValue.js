// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const orders = apex.model.get("orbitOrders");
const record = orders.getRecord("2279");
console.log(orders.getRecordId(record), orders.getValue(record, "CUSTOMER"), orders.getValue(record, "TOTAL"));
console.log("index:", orders.indexOf(record), "- recordAt(0):", orders.getValue(orders.recordAt(0), "ORDER_NUMBER"));
console.log("getRecordValue:", orders.getRecordValue("2282", "STATUS"));
orders.setValue(record, "STATUS", "SHIPPED");
orders.setRecordValue("2278", "STATUS", "SHIPPED");
console.log("after set:", orders.getValue(record, "STATUS"), orders.getRecordValue("2278", "STATUS"));
try { orders.setValue(record, "ORDER_ID", "9999"); } catch (e) { console.log("readonly field:", e.message); }
