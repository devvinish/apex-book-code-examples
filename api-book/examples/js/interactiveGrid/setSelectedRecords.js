// @page stores
const stores = apex.region("stores");
stores.on("interactivegridselectionchange", (event, data) =>
    console.log("selectionchange:", data.selectedRecords.map((r) => data.model.getValue(r, "STORE_NAME"))));
stores.call("setSelectedRecords", ["3", "5"]);             // record IDs (or records)
const model = stores.call("getViews", "grid").model;
console.log("selected:", stores.call("getSelectedRecords").map((r) => model.getRecordId(r)));
await new Promise((resolve) => setTimeout(resolve, 300));  // the event follows a moment later
stores.call("setSelectedRecords", [], false, true);         // clear, without the event
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("after clearing:", stores.call("getSelectedRecords").length);
