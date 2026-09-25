// @page products
const search = apex.region("product_search");
const counts = search.getFacetValueCounts();
console.log("total:", search.getTotalResourceCount());
console.log("P4_PRICE:", counts.P4_PRICE);
console.log("P4_IS_ACTIVE:", counts.P4_IS_ACTIVE);
console.log("P4_COLOR:", counts.P4_COLOR);
