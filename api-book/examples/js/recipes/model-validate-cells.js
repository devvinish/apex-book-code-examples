// @page stores
// @shot #stores .a-GV-bdy tr[data-id='2']
// @wait 600
// === Page › Execute when Page Loads ===
// A rule across two columns: a flagship store needs at least 8,000 sq ft.
const stores = apex.region("stores").call("getViews", "grid").model;
function checkFloorArea(record) {
    const id = stores.getRecordId(record);
    const area = apex.locale.toNumber(stores.getValue(record, "FLOOR_AREA_SQFT") || "0");
    if (stores.getValue(record, "FLAGSHIP").v && area < 8000) {
        stores.setValidity("error", id, "FLOOR_AREA_SQFT",
                           "A flagship store needs at least 8,000 sq ft.");
    } else {
        stores.setValidity("valid", id, "FLOOR_AREA_SQFT");
    }
}
stores.subscribe({
    onChange: (type, change) => {
        if (type === "set" && ["FLAGSHIP", "FLOOR_AREA_SQFT"].includes(change.field)) {
            checkFloorArea(change.record);
        }
    }
});
// === Try it: make Boulder (6,400 sq ft) a flagship, then enlarge it ===
const boulder = stores.getRecord("2");
stores.setValue(boulder, "FLAGSHIP", { v: true, d: "On" });
console.log("errors:", stores.hasErrors(), "-",
            stores.getRecordMetadata("2").fields.FLOOR_AREA_SQFT.message);
stores.setValue(boulder, "FLOOR_AREA_SQFT", "8500");
console.log("errors after 8,500 sq ft:", stores.hasErrors());
stores.setValue(boulder, "FLOOR_AREA_SQFT", "6400");        // (for the picture)
