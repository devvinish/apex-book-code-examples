// @page stores
// @wait 600
// === Page › Execute when Page Loads ===
// The names of flagship stores cannot be edited in the grid.
const grid = apex.region("stores").call("getViews", "grid");
function lockFlagshipNames() {
    grid.model.forEach((record, index, id) => {
        const meta = grid.model.getRecordMetadata(id);
        meta.fields = meta.fields || {};
        meta.fields.STORE_NAME = meta.fields.STORE_NAME || {};
        meta.fields.STORE_NAME.disabled = !!grid.model.getValue(record, "FLAGSHIP").v;
        grid.model.metadataChanged(id, "STORE_NAME");        // the grid redraws the cell
    });
}
lockFlagshipNames();
grid.model.subscribe({                                       // again for new data and changes
    onChange: (type, change) => {
        if (["refresh", "addData"].includes(type) || (type === "set" && change.field === "FLAGSHIP")) {
            lockFlagshipNames();
        }
    }
});
// === Try it: turn on edit mode and go to the name of Denver (a flagship), then of Boulder ===
apex.region("stores").call("getActions").set("edit", true);
for (const id of ["1", "2"]) {
    grid.view$.grid("gotoCell", id, "STORE_NAME");
    await new Promise((resolve) => setTimeout(resolve, 300));
    console.log(grid.model.getValue(grid.model.getRecord(id), "STORE_NAME"), "→",
                document.activeElement.tagName === "INPUT" ? "editable" : "read-only");
}
