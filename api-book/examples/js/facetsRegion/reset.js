// @page products
const search = apex.region("product_search");
const done = () => new Promise((resolve) => setTimeout(resolve, 2000));   // report and counts
apex.item("P4_IS_ACTIVE").setValue("TRUE");
await done();
console.log("filtered:", search.getTotalResourceCount());
search.reset();
await done();
console.log("reset:   ", search.getTotalResourceCount(), "- filters:", search.getFacetCount(true));
