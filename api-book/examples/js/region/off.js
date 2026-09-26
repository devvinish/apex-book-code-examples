// @page stores
const stores = apex.region("stores");
const handler = (event, data) => console.log("selected stores:", data.selectedRecords.length);
stores.on("interactivegridselectionchange", handler);
const grid = stores.call("getViews", "grid");
stores.call("setSelectedRecords", [grid.model.recordAt(1)], true);
await new Promise((resolve) => setTimeout(resolve, 300));
stores.off("interactivegridselectionchange", handler);
stores.call("setSelectedRecords", [grid.model.recordAt(2), grid.model.recordAt(3)], true);  // not logged
console.log("handler removed");
