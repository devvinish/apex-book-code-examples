// @page stores
const grid = apex.region("stores").call("getViews", "grid");
const cell = grid.view$.find("td").filter((i, td) => td.textContent.trim() === "Chicago")[0];   // a cell of the grid
const [record] = grid.getContextRecord(cell);
console.log(grid.model.getValue(record, "STORE_NAME"), "- ID", grid.model.getRecordId(record));
grid.setSelectedRecords([record]);
console.log("view selection:", grid.getSelectedRecords().map((r) => grid.model.getValue(r, "CITY")));
