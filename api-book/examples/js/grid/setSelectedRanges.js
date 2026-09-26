// @page stores
const grid$ = apex.region("stores").call("getViews", "grid").view$;   // the grid widget of the Stores grid
const model = grid$.grid("getModel");
grid$.grid("setEditMode", true);
grid$.grid("option", { selectCells: true });             // cell range selection
grid$.grid("setSelectedRanges", [{ startRowIndex: 0, startColIndex: 2, endRowIndex: 2, endColIndex: 3 }]);
console.log("ranges:", grid$.grid("getSelectedRanges"));
console.log("cells:", grid$.grid("getSelection").map((row$) => row$.map((i, td) => td.textContent).get().join(" | ")));
grid$.grid("fillSelection", "Colorado", ["STATE"]);        // fill STATE of the selected rows
await new Promise((resolve) => setTimeout(resolve, 300));   // the grid writes the model a moment later
console.log("STATE:", [0, 1, 2].map((i) => model.getValue(model.recordAt(i), "STATE")));
grid$.grid("copyDownSelection", ["CITY"]);                // copy the first row's CITY down
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("CITY:", [0, 1, 2].map((i) => model.getValue(model.recordAt(i), "CITY")));
model.revertRecords([0, 1, 2].map((i) => model.recordAt(i)));
