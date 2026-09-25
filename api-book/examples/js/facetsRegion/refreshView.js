// @page products
const search = apex.region("product_search");
const labels = () => search.widget().find(".a-FS-label").map((i, e) => e.textContent.trim()).get().join(" | ");
console.log(labels());
search.controls[0].label = "Product Category";
search.refreshView();                                     // render the facets again
console.log(labels());
