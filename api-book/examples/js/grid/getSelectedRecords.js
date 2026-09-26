// @page stores
const grid$ = apex.region("stores").call("getViews", "grid").view$;   // the grid widget of the Stores grid
const model = grid$.grid("getModel");
grid$.on("gridselectionchange", () => console.log("selectionchange:", grid$.grid("getSelectedRecords").length, "row(s)"));
grid$.grid("setSelectedRecords", [model.getRecord("2"), model.getRecord("7")]);
await new Promise((resolve) => setTimeout(resolve, 200));
console.log("rows:", grid$.grid("getSelection").map((row$) => row$.find("td").eq(1).text()));
grid$.grid("setSelection", grid$.find("tbody tr").slice(0, 1), false, true);   // the first row, no event
console.log("records:", grid$.grid("getSelectedRecords").map((r) => model.getValue(r, "CITY")));
grid$.grid("selectAll");
await new Promise((resolve) => setTimeout(resolve, 200));
