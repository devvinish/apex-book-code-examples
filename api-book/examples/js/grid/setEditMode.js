// @page stores
const grid$ = apex.region("stores").call("getViews", "grid").view$;   // the grid widget of the Stores grid
grid$.on("gridmodechange", (event, data) => console.log("modechange:", data.editMode));
grid$.grid("gotoCell", "3", "CITY");
grid$.grid("setEditMode", true);
console.log("in edit mode:", grid$.grid("inEditMode"), "- active record:", grid$.grid("getActiveRecordId"));
const cityItem = grid$.grid("getColumns").find((c) => c.property === "CITY").elementId;
console.log("column item:", cityItem, "- cell:", grid$.grid("getActiveCellFromColumnItem", apex.item(cityItem).node).attr("class"));
apex.item(cityItem).setValue("Seattle (Capitol Hill)", null, true);   // no change event...
grid$.grid("setActiveRecordValue", "CITY");               // ...so write it to the model
await grid$.grid("finishEditing");
const model = grid$.grid("getModel");
console.log("model CITY:", model.getRecordValue("3", "CITY"));
model.revertRecords([model.getRecord("3")]);
grid$.grid("setEditMode", false);
