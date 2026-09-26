// @page stores
const stores = apex.region("stores");
stores.on("interactivegridmodechange", (event, data) => console.log("modechange: editMode", data.editMode));
stores.call("getActions").set("edit", true);                // switch to edit mode
stores.call("gotoCell", null, "4", "CITY");                 // record ID 4, column CITY
const cell = document.activeElement.closest("td, .a-GV-cell") ?? document.activeElement;
console.log("focus in:", cell.textContent.trim() || document.activeElement.value);
stores.call("getActions").set("edit", false);
