// @page stores
// @wait 600
// @shot #stores .a-GV-bdy
// === Page › Execute when Page Loads ===
// Rows of stores that opened in the last five years get a light amber background.
const grid = apex.region("stores").call("getViews", "grid");
grid.view$.grid("option", "highlights", {
    "new-store": { row: true, background: "#fdf0cf", seq: 1 }       // the rule, as CSS
});
function markNewStores() {
    const since = apex.date.subtract(new Date(), 5, apex.date.UNIT.YEAR);
    grid.model.forEach((record, index, id) => {
        const opened = apex.date.parse(grid.model.getValue(record, "OPENED_ON"), "DD-MON-YYYY");
        const isNew = apex.date.isAfter(opened, since);
        grid.model.getRecordMetadata(id).highlight = isNew ? "new-store" : null;
        grid.model.metadataChanged(id);
    });
}
markNewStores();
grid.model.subscribe({
    onChange: (type) => { if (["refresh", "addData"].includes(type)) markNewStores(); }
});
// === Try it: which rows have the class of the rule ===
apex.region("stores").call("setSelectedRecords", [], false, true);   // (no selection in the picture)
console.log($("#stores tr.hlr_new-store td:nth-child(3)").map((i, cell) => cell.textContent).get());
