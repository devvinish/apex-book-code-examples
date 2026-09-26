// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const orders = apex.model.get("orbitOrders");
console.log("changed:", orders.isChanged());
orders.setRecordValue("2279", "STATUS", "SHIPPED");
orders.deleteRecords([orders.getRecord("2280")]);
orders.insertNewRecord();
for (const meta of orders.getChanges()) {
    console.log(orders.getRecordId(meta.record), { inserted: !!meta.inserted, updated: !!meta.updated, deleted: !!meta.deleted },
                meta.original ? "was " + orders.getValue(meta.original, "STATUS") : "");
}
console.log("can revert 2279:", orders.canRevertRecord(orders.getRecord("2279")));
console.log("reverted:", orders.revertRecords([orders.getRecord("2279"), orders.getRecord("2280")]),
            "- 2279 is", orders.getRecordValue("2279", "STATUS"));
orders.clearChanges();
console.log("after clearChanges:", orders.isChanged(), "- records:", orders.getTotalRecords());
