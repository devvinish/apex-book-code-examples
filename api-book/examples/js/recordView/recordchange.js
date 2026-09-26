// @page stores
const stores = apex.region("stores");
stores.call("setSelectedRecords", ["7"]);
stores.call("getActions").invoke("single-row-view");
const rv$ = stores.call("getViews", "grid").singleRowView$;
rv$.on("recordviewrecordchange", () => console.log("recordchange:", rv$.recordView("getModel").getRecordId(rv$.recordView("getRecord"))));
rv$.on("recordviewmodechange", (event, data) => console.log("modechange:", data.editMode));
rv$.recordView("getActions").invoke("next-record");       // the Next button of its toolbar
await new Promise((resolve) => setTimeout(resolve, 300));
rv$.recordView("gotoField", "9", "CITY");
await new Promise((resolve) => setTimeout(resolve, 300));
rv$.recordView("setEditMode", true);
console.log("in edit mode:", rv$.recordView("inEditMode"), "- active:", rv$.recordView("getActiveRecordId"));
console.log("toolbar buttons:", rv$.recordView("getToolbar").find("button").map((i, b) => b.title || b.textContent.trim()).get().join(", "));
rv$.recordView("setEditMode", false);
