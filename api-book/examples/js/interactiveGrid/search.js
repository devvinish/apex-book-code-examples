// @page stores
const stores = apex.region("stores");
stores.on("interactivegridreportsettingschange", (event, data) => console.log("reportsettingschange"));
apex.jQuery("#stores_ig_toolbar_search_field").val("Denver");
stores.call("getActions").invoke("search");                 // the toolbar's search
await new Promise((resolve) => setTimeout(resolve, 1500));
console.log("rows:", stores.call("getViews", "grid").model.getTotalRecords());
stores.call("getActions").invoke("reset-report");           // back to the saved report
await new Promise((resolve) => setTimeout(resolve, 1500));
console.log("after reset-report:", stores.call("getViews", "grid").model.getTotalRecords());
