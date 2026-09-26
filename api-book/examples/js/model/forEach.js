// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const orders = apex.model.get("orbitOrders");
let sum = 0;
orders.forEach((record, index, id) => { sum += Number(orders.getValue(record, "TOTAL")); });
console.log("records:", orders.getTotalRecords(), "- total:", sum.toFixed(2));
orders.forEachInPage(1, 2, (record, index, id) => console.log("page:", index, id, orders.getValue(record, "CUSTOMER")));
console.log("server total:", orders.getServerTotalRecords(), "- overflow:", orders.getDataOverflow());
