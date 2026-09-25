// @page stores
const stores = apex.region("stores");
stores.on("interactivegridselectionchange", function (event, data) {
    console.log("selected stores:", data.selectedRecords.length);
});
const grid = stores.call("getViews", "grid");
stores.call("setSelectedRecords", [grid.model.recordAt(0), grid.model.recordAt(1)], true);
