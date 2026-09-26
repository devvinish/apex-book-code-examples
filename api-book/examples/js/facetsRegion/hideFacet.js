// @page products
const search = apex.region("product_search");
const visible = () => search.widget().find(".a-FS-label:visible").map((i, e) => e.textContent).get().join(", ");
search.hideFacet("P4_SUPPLIER_ID");
search.hideFacet("P4_IS_ACTIVE");
console.log("visible:", visible());
search.showFacet("P4_IS_ACTIVE");
console.log("visible:", visible());
