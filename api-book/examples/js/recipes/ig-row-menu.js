// @page stores
// @shot clip 0,160,1280,480
// === Page › Execute when Page Loads ===
const grid = apex.region("stores").call("getViews", "grid");
const menuItems = grid.rowActionMenu$.menu("option", "items");
menuItems.push(
    { type: "separator" },
    {
        type: "action",
        label: "Store Details",
        icon: "fa fa-info-circle",
        action: function(menu, button) {
            const record = grid.getContextRecord(button)[0];         // the row of the menu
            const model  = grid.model;
            apex.message.alert(`${model.getValue(record, "STORE_NAME")}: ` +
                `${model.getValue(record, "FLOOR_AREA_SQFT").trim()} sq ft, opened ` +
                `${model.getValue(record, "OPENED_ON")}.`);
        }
    }
);
// === Try it: open the row actions menu of Seattle and choose Store Details ===
const row$ = $("#stores .a-GV-row").filter((i, row) => /Seattle/.test(row.textContent)).first();
row$.find("button.a-Button--actions").trigger("click");
await new Promise((resolve) => setTimeout(resolve, 400));
const menu$ = $(".a-Menu:visible");
console.log(menu$.find(".a-Menu-label").map((i, e) => e.textContent).get());
const item = menu$.find(".a-Menu-label").filter((i, e) => e.textContent === "Store Details")[0];
for (const type of ["mousedown", "mouseup", "click"]) {                 // what a mouse click sends
    item.dispatchEvent(new MouseEvent(type, { bubbles: true, cancelable: true, view: window }));
}
await new Promise((resolve) => setTimeout(resolve, 500));
console.log($(".ui-dialog:visible .a-AlertMessage-details").text().trim());
$(".ui-dialog:visible .ui-dialog-buttonpane button").last().trigger("click");
await new Promise((resolve) => setTimeout(resolve, 400));
row$.find("button.a-Button--actions").trigger("click");      // open it again for the picture
