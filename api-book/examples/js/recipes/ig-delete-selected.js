// @page stores
// @iginit
// @wait 1500
// === Region Stores › Attributes › Initialization JavaScript Function ===
function(options) {
    const toolbar = $.apex.interactiveGrid.copyDefaultToolbar();
    toolbar.toolbarFind("actions3").controls.push({
        type: "BUTTON", action: "delete-selected", icon: "fa fa-trash-o", iconBeforeLabel: true
    });
    options.toolbarData = toolbar;
    options.initActions = function(actions) {
        actions.add({
            name: "delete-selected",
            label: "Delete Selected",
            action: function() {
                const count = apex.region("stores").call("getSelectedRecords").length;
                if (!count) {
                    apex.message.alert("Select the stores to delete first.");
                    return;
                }
                apex.message.confirm(`Delete ${count} selected store(s)?`, (okPressed) => {
                    if (okPressed) {
                        actions.invoke("selection-delete");   // marks the rows as deleted
                        actions.invoke("save");               // and saves at once
                    }
                });
            }
        });
    };
    return options;
}
// --- after the page loads ---
// === Try it: add a test store, then select it and delete it ===
const region = apex.region("stores");
const model  = region.call("getCurrentView").model;
const id = model.insertNewRecord();                          // (what Add Row does)
const record = model.getRecord(id);
model.setValue(record, "STORE_NAME", "Orbit Test Store");
model.setValue(record, "CITY", "Testville");
region.call("getActions").invoke("save");
await new Promise((resolve) => setTimeout(resolve, 2500));
console.log("stores:", model.getTotalRecords());
const saved = [];
model.forEach((r) => {
    if (model.getValue(r, "STORE_NAME") === "Orbit Test Store") saved.push(r);
});
region.call("setSelectedRecords", saved);
$("#stores button[data-action='delete-selected']").trigger("click");
await new Promise((resolve) => setTimeout(resolve, 500));
console.log("confirm:", $(".ui-dialog:visible .a-AlertMessage-details").text().trim());
$(".ui-dialog:visible .ui-dialog-buttonpane button").last().trigger("click");   // OK
await new Promise((resolve) => setTimeout(resolve, 2500));
console.log("stores:", model.getTotalRecords());
