// @page stores
// @shot #stores
const stores = apex.region("stores");
stores.call("setSelectedRecords", ["7"]);
stores.call("getActions").invoke("single-row-view");      // the Single Row View of the grid
const grid = stores.call("getViews", "grid");
const rv$ = grid.singleRowView$;                            // a recordView widget
console.log("singleRowMode:", grid.singleRowMode);
const model = rv$.recordView("getModel");
console.log("record:", model.getRecordId(rv$.recordView("getRecord")), model.getValue(rv$.recordView("getRecord"), "STORE_NAME"));
console.log("fields:", rv$.recordView("getFields").slice(0, 4).map((f) => f.property));
console.log("CITY field:", rv$.recordView("fieldElement", "CITY").find("label").text());
