// @page product-catalog
const catalog = apex.region("catalog");
const model = catalog.getModel();
console.log("model:", model.name, "- records:", model.getTotalRecords());
model.forEach((record, index) => {
    if (index < 3) console.log(model.getValue(record, "SKU"), model.getValue(record, "PRODUCT_NAME"),
                               model.getValue(record, "PRICE"));
});
