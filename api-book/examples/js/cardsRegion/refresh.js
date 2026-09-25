// @page product-catalog
const catalog = apex.region("catalog");
const model = catalog.getModel();
await catalog.refresh();
console.log("refreshed:", catalog.getModel().getTotalRecords(), "records");
console.log("same model:", model === catalog.getModel());
