// @page stores
const grid$ = apex.region("stores").call("getViews", "grid").view$;   // the grid widget of the Stores grid
grid$.on("gridcurrentcellchange", () => console.log("currentcellchange"));
grid$.grid("gotoCell", "5", "CITY");
const cell$ = grid$.grid("getCurrentCell");
console.log("current cell:", cell$.text(), "- column:", grid$.grid("getColumnForCell", cell$).property);
grid$.grid("setCurrentCell", cell$.next(), true);
console.log("current cell:", grid$.grid("getCurrentCell").text());
await new Promise((resolve) => setTimeout(resolve, 200));
