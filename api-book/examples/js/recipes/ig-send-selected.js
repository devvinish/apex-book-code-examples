// @page stores
// @wait 1500
// @shot clip 0,0,1280,150
// === Try it: select three stores ===
apex.region("stores").call("setSelectedRecords", ["3", "5", "9"]);
// === Button Summarize › Dynamic Action › Execute JavaScript Code ===
const region = apex.region("stores");
const model  = region.call("getCurrentView").model;
const ids    = region.call("getSelectedRecords").map((record) => model.getRecordId(record));
if (!ids.length) {
    apex.message.alert("Select at least one store.");
} else {
    apex.server.process("STORE_SUMMARY", { f01: ids })          // an array goes as f01
        .then((data) => {
            console.log(data);
            apex.message.showPageSuccess(`${data.stores.length} stores, ` +
                `${apex.locale.formatNumber(data.totalSqft, "FM999G999G999")} sq ft in total.`);
        });
}
