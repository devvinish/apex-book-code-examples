// @page stores
const stores = apex.region("stores");
stores.call("refresh");                                     // same as stores.refresh()
await new Promise((resolve) => setTimeout(resolve, 1500));
console.log("toolbar buttons:", stores.call("getToolbar").find("button").length);
stores.call("resize");                                      // after the grid's container changed size
stores.call("focus");
console.log("focus in:", document.activeElement.id || document.activeElement.className);
