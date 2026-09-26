// @page stores
const model = apex.model.get("stores_grid");               // the interactive grid's model
const id = model.getRecordId(model.recordAt(0));
const original = model.getRecordValue(id, "STORE_NAME");
model.setRecordValue(id, "STORE_NAME", original + " (renovated)");
await model.save();                                         // the grid's DML process saves the row
console.log("saved:", !model.isChanged(), "-", model.getRecordValue(id, "STORE_NAME"));
model.setRecordValue(id, "STORE_NAME", original);          // put it back
await apex.model.save();                                    // saves all changed models
console.log("restored:", model.getRecordValue(id, "STORE_NAME"), "- changes:", apex.model.anyChanges());
