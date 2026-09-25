// @page stores
const stores = apex.region("stores");
console.log("views:", Object.keys(stores.call("getViews")), "- current:", stores.call("getCurrentViewId"));
const grid = stores.call("getCurrentView");
console.log({ internalIdentifier: grid.internalIdentifier, title: grid.title, icon: grid.icon,
              modelName: grid.modelName, singleRowMode: grid.singleRowMode, viewElement: grid.view$.attr("id") });
console.log("records in the view's model:", grid.model.getTotalRecords());
