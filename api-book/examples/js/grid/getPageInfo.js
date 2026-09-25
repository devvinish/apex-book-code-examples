// @page stores
const grid$ = apex.region("stores").call("getViews", "grid").view$;   // the grid widget of the Stores grid
grid$.on("gridpagechange", (event, data) => console.log("pagechange: offset", data.offset, "count", data.count));
console.log("page info:", grid$.grid("getPageInfo"));
grid$.grid("option", { pagination: { scroll: false, showRange: true }, rowsPerPage: 5 });
grid$.grid("refresh");
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("nextPage:", grid$.grid("nextPage"));
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("gotoPage(2):", grid$.grid("gotoPage", 2));
await new Promise((resolve) => setTimeout(resolve, 300));
const info = grid$.grid("getPageInfo");
console.log("first:", info.firstOffset, "last:", info.lastOffset, "total:", info.total);
