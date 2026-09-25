// @page stores
const stores = apex.region("stores");
const model = stores.call("getViews", "grid").model;
const original = model.getRecordValue("2", "CITY");
stores.on("interactivegridsave", (event, data) => console.log("save event:", data.status));
model.setRecordValue("2", "CITY", "Boulder (Pearl St)");
stores.call("getActions").invoke("save");
await new Promise((resolve) => setTimeout(resolve, 2000));
model.setRecordValue("2", "CITY", original);               // put it back
stores.call("getActions").invoke("save");
await new Promise((resolve) => setTimeout(resolve, 2000));
console.log("CITY:", model.getRecordValue("2", "CITY"), "- changes:", model.isChanged());
