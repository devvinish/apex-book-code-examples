// @page stores
const stores = apex.region("stores");
const grid = stores.call("getViews", "grid");            // interactiveGrid getViews method
console.log("records:", grid.model.getTotalRecords());
console.log("current view:", stores.call("getCurrentViewId"));
