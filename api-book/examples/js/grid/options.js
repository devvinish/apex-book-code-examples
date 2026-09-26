// @page stores
const grid$ = apex.region("stores").call("getViews", "grid").view$;   // the grid widget of the Stores grid
const o = (name) => grid$.grid("option", name);
console.log({ editable: o("editable"), rowHeader: o("rowHeader"), rowHeaderCheckbox: o("rowHeaderCheckbox"),
              multiple: o("multiple"), selectCells: o("selectCells"), persistSelection: o("persistSelection"),
              columnSort: o("columnSort"), reorderColumns: o("reorderColumns"), showNullAs: o("showNullAs") });
console.log("pagination:", o("pagination"));
grid$.grid("option", "rowHeader", "sequence");            // row numbers instead of check boxes
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("row headers:", grid$.find("tbody th").slice(0, 5).map((i, th) => th.textContent.trim()).get().join(" "));
