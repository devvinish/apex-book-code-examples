// @page stores
const grid$ = apex.region("stores").call("getViews", "grid").view$;   // the grid widget of the Stores grid
grid$.grid("gotoCell", "4", "CITY");
grid$.grid("setEditMode", true);
grid$.grid("lockActive");                                  // e.g. while a Set Value action calls the server
const done = new Promise((resolve) => setTimeout(() => {
    apex.item(grid$.grid("getColumns").find((c) => c.property === "STATE").elementId).setValue("Oregon");
    grid$.grid("unlockActive");
    resolve();
}, 500));
grid$.grid("gotoCell", "6", "CITY");                        // the user moves on: waits for the unlock
await done;
await grid$.grid("finishEditing");
console.log("record 4 STATE:", grid$.grid("getModel").getRecordValue("4", "STATE"), "- active:", grid$.grid("getActiveRecordId"));
