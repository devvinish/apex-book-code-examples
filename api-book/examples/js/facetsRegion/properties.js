// @page products
const search = apex.region("product_search");
console.log("uiMode:", search.uiMode, "- batch:", search.batch, "- feedback:", search.feedback);
console.log("searchItem:", search.searchItem, "- currentFacets:", search.currentFacets);
for (const control of search.controls) {
    console.log(control.name.padEnd(15), control.type.padEnd(10), control.label.padEnd(10),
                (control.values || []).length, "values");
}
