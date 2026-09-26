// @page stores
const model = apex.model.get("stores_grid");               // the interactive grid's model
console.log("changes:", apex.model.anyChanges(), "- errors:", apex.model.anyErrors());
model.setValue(model.recordAt(0), "STORE_NAME", "Orbit Denver Union Station (renovated)");
console.log("changes:", apex.model.anyChanges(), "- for this model:", apex.model.anyChanges(false, "stores_grid"));
const request = {};
apex.model.addChangesToSaveRequest(request);
const region = request.regions[0];
console.log("region properties:", Object.keys(region));
const row = region.saveData.models[0].values[0];           // the grid's records are arrays
console.log("changed row:", row.slice(0, 3), "- operation:", row.at(-1).op);
