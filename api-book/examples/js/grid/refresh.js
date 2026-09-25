// @page stores
const grid$ = apex.region("stores").call("getViews", "grid").view$;   // the grid widget of the Stores grid
const columns = grid$.grid("getColumns");
columns.find((c) => c.property === "CITY").heading = "Town";   // changed outside the grid
grid$.grid("refreshColumns");
grid$.grid("refresh");
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("heading:", grid$.find("thead th").filter((i, th) => th.textContent.trim() === "Town").length > 0);
grid$.grid("resize");
grid$.grid("fetchAllData");
grid$.grid("debugCellEdit", true);                       // item plug-in developers: keep editors in cells
