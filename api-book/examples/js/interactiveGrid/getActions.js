// @page stores
const actions = apex.region("stores").call("getActions");
const model = apex.region("stores").call("getViews", "grid").model;
console.log("actions:", actions.list().length, "- rows:", model.getTotalRecords());
actions.invoke("selection-add-row");                        // the toolbar's Add Row button
console.log("after selection-add-row:", model.getTotalRecords(), "rows, changed:", model.isChanged());
