// @page customers
const report = apex.region("customers");
console.log("type:", report.type);
console.log("element:", report.element.attr("id"));

// apex.regions holds the same interface
console.log(apex.regions.customers === report);

// a region that is not on the page
console.log(apex.region("no_such_region"));
