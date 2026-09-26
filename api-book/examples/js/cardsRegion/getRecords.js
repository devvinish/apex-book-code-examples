// @page product-catalog
const catalog = apex.region("catalog");
const model = catalog.getModel();
const cards$ = catalog.element.find(".a-CardView-item").slice(0, 2);
for (const record of catalog.getRecords(cards$)) {
    console.log(model.getRecordId(record), model.getValue(record, "PRODUCT_NAME"),
                model.getValue(record, "STOCK_ON_HAND"), "in stock");
}
