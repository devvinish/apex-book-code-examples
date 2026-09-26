// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const orders = apex.model.get("orbitOrders");
orders.subscribe({ onChange: (type) => console.log("notification:", type) });
orders.clearData();
console.log("after clearData:", orders.getTotalRecords());
orders.setData([{ ORDER_ID: "2276", ORDER_NUMBER: "ORD-12276", CUSTOMER: "Riverbend Guides", STATUS: "APPROVED", TOTAL: "9051.16" }]);
console.log("after setData:", orders.getTotalRecords(), orders.getRecordValue("2276", "CUSTOMER"));
