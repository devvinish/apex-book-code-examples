// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const orders = apex.model.get("orbitOrders");
const viewId = orders.subscribe({
    viewId: "orbit_log",
    onChange: (changeType, change) => console.log("notification:", changeType,
        change.recordId ?? change.records?.map((r) => orders.getRecordId(r)) ?? "", change.field ?? "")
});
orders.setRecordValue("2279", "STATUS", "SHIPPED");
orders.insertNewRecord();
orders.deleteRecords([orders.getRecord("2280")]);
orders.revertRecords([orders.getRecord("2279")]);
orders.setValidity("error", "2278", "TOTAL", "Too high");
orders.clearChanges();
orders.unSubscribe(viewId);
orders.setRecordValue("2282", "STATUS", "RETURNED");      // no longer observed
