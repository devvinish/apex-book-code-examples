// @page stores
const grid$ = apex.region("stores").call("getViews", "grid").view$;   // the grid widget of the Stores grid
const show = () => grid$.grid("getColumns").filter((c) => !c.hidden).map((c) => c.property).join(" ");
console.log(grid$.grid("getColumns").filter((c) => !c.property.startsWith("APEX$")).slice(0, 3).map((c) => ({ name: c.property, heading: c.heading, width: c.width, seq: c.seq })));
grid$.grid("hideColumn", "COUNTRY");
grid$.grid("moveColumn", "CITY", 0);
grid$.grid("setColumnWidth", "STORE_NAME", 300);
grid$.grid("freezeColumn", "STORE_NAME");
console.log("visible:", show());
const nameColumn = grid$.grid("getColumns").find((c) => c.property === "STORE_NAME");
console.log("STORE_NAME:", { width: nameColumn.width, frozen: nameColumn.frozen });
grid$.grid("showColumn", "COUNTRY");
grid$.grid("unfreezeColumn", "STORE_NAME");
