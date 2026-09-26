// @page products
const search = apex.region("product_search");
const done = () => new Promise((resolve) => setTimeout(resolve, 2000));   // report and counts
const show = (label) => console.log(label.padEnd(12), search.getFacetCount(true), "filters,",
                                    search.getTotalResourceCount(), "products");
apex.item("P4_CATEGORY_ID").setValue("I11");            // Backpacks
await done();
apex.item("P4_SEARCH").setValue("daypack");
await done();
show("filtered:");
search.clearFacets();
await done();
show("clearFacets:");
search.clear();
await done();
show("clear:");
