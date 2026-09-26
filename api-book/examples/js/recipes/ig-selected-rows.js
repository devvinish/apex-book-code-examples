// @page stores
// === Try it: select three stores (or click their check boxes) ===
apex.region("stores").call("setSelectedRecords", ["3", "5", "9"]);
// === Button Show Selection › Dynamic Action › Execute JavaScript Code ===
const region = apex.region("stores");
const model  = region.call("getCurrentView").model;
const rows   = region.call("getSelectedRecords").map((record) => ({
    id:   model.getRecordId(record),
    name: model.getValue(record, "STORE_NAME"),
    area: apex.locale.toNumber(model.getValue(record, "FLOOR_AREA_SQFT"))   // "9,800" → 9800
}));
rows.forEach((row) => console.log(row));
console.log("IDs:", rows.map((row) => row.id).join(":"));
console.log("total area:", rows.reduce((sum, row) => sum + row.area, 0));
