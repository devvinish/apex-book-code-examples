// @page stores
const stores = apex.region("stores");
const grid = stores.call("getViews", "grid");
const city = grid.getColumns().find((column) => column.property === "CITY");

// edit the City cell of the first store: its column item is now in that cell
stores.call("getActions").set("edit", true);
grid.view$.grid("gotoCell", grid.model.getRecordId(grid.model.recordAt(0)), "CITY");
await new Promise((resolve) => setTimeout(resolve, 500));

const indicator$ = apex.jQuery('<span class="u-Processing u-Processing--inline"></span>');
const placed$ = stores.alternateLoadingIndicator($x(city.elementId), indicator$);
console.log("indicator placed:", placed$.length, "- in a grid cell:", placed$.closest("td").length === 1);
