// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const orders = apex.model.get("orbitOrders");
orders.setSelectionState("2279", true);
orders.setSelectionState("2277", true);
console.log("count:", orders.getSelectedCount(), "- records:", orders.getSelectedRecords().map((r) => orders.getRecordId(r)));
console.log("state:", orders.getSelectionState());
orders.setSelectionState("2279", true, "toggle");
orders.clearSelection();
console.log("after clearSelection:", orders.getSelectedCount());
