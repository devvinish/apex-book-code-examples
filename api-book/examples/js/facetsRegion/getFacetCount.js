// @page products
const search = apex.region("product_search");
const done = () => new Promise((resolve) => setTimeout(resolve, 2000));   // report and counts
apex.item("P4_COLOR").setValue("IBlack");
await done();
apex.item("P4_SEARCH").setValue("merino");
await done();
console.log("facets:", search.getFacetCount(false), "- with search terms:", search.getFacetCount(true));
