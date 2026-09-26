// @page stores
const model = apex.model.get(apex.model.list()[0]);         // the interactive grid's model
console.log("records:", model.getTotalRecords(), "- server total:", model.getServerTotalRecords());
model.clearData(false);
await model.fetch(0);
console.log("fetched:", model.getTotalRecords(true));
let calls = 0;
await new Promise((resolve) => model.fetchAll((status) => { calls++; if (status.done) resolve(); }));
console.log("fetchAll:", calls, "call(s), records:", model.getTotalRecords());
const first = model.recordAt(0);
await model.fetchRecords([first]);
console.log("fetchRecords: refreshed", model.getRecordId(first));
console.log("control breaks:", model.hasControlBreaks(), "- getControlBreakId:", model.getControlBreakId(first));
