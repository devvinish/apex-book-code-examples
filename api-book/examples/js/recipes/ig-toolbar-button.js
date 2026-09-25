// @page stores
// @iginit
// @shot #stores
// @wait 2500
// @after const v = apex.region("stores").call("getViews", "grid"); ["2", "4"].forEach((id) => v.model.setValue(v.model.getRecord(id), "FLAGSHIP", { v: false, d: "Off" })); apex.region("stores").call("getActions").invoke("save"); await new Promise((r) => setTimeout(r, 2500));
// === Region Stores › Attributes › Initialization JavaScript Function ===
function(options) {
    const toolbar = $.apex.interactiveGrid.copyDefaultToolbar();
    toolbar.toolbarFind("actions3").controls.push({
        type: "BUTTON", action: "mark-flagship", icon: "fa fa-star", iconBeforeLabel: true, hot: true
    });
    options.toolbarData = toolbar;
    options.initActions = function(actions) {
        actions.add({
            name: "mark-flagship",
            label: "Mark as Flagship",
            disabled: true,                                   // until rows are selected
            action: function() {
                const view = apex.region("stores").call("getCurrentView");
                // FLAGSHIP is a Yes/No column: its value is an object
                view.getSelectedRecords().forEach((record) =>
                    view.model.setValue(record, "FLAGSHIP", { v: true, d: "On" }));
                actions.invoke("save");
            }
        });
    };
    return options;
}
// --- after the page loads ---
// === Page › Execute when Page Loads ===
apex.region("stores").on("interactivegridselectionchange", (event, data) => {
    const actions = apex.region("stores").call("getActions");
    if (data.selectedRecords.length) actions.enable("mark-flagship");
    else actions.disable("mark-flagship");
});
apex.region("stores").on("interactivegridsave", () =>
    apex.message.showPageSuccess("Flagship stores saved."));
// === Try it: select two stores and click the button ===
apex.region("stores").call("setSelectedRecords", ["2", "4"]);
await new Promise((resolve) => setTimeout(resolve, 300));
$("#stores button[data-action='mark-flagship']").trigger("click");
await new Promise((resolve) => setTimeout(resolve, 2000));
const model = apex.region("stores").call("getCurrentView").model;
console.log(["2", "4"].map((id) => model.getValue(model.getRecord(id), "STORE_NAME") + ": " +
                                   model.getValue(model.getRecord(id), "FLAGSHIP").d));
