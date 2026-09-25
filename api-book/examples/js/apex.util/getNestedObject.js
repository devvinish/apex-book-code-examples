const settings = {};
apex.util.getNestedObject(settings, "report.columns.price").width = 120;
apex.util.getNestedObject(settings, "report.columns.sku").hidden = true;
console.log(settings);
