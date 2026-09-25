// @page stores
// @wait 1200
const stores = apex.region("stores");
stores.element
    .on("apexbeginrecordedit", (event, data) => console.log("begin editing store", data.recordId))
    .on("apexendrecordedit", (event, data) => console.log("end editing store", data.recordId));

const grid = stores.call("getViews", "grid");
const first = grid.model.getRecordId(grid.model.recordAt(0));
const second = grid.model.getRecordId(grid.model.recordAt(1));
stores.call("getActions").set("edit", true);        // edit mode
grid.view$.grid("gotoCell", first, "CITY");          // edit the first store
await new Promise((resolve) => setTimeout(resolve, 500));
grid.view$.grid("gotoCell", second, "CITY");         // move to the second store
