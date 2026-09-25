// @page product-catalog
// @onload
// @wait 1500
// === Page › Execute when Page Loads ===
// Remembers the sort order the user chose in the catalog, in the browser, for the next visit.
const prefs = apex.storage.getScopedLocalStorage({ prefix: "catalog", useAppId: true });
const saved = prefs.getItem("orderBy");
if (saved && saved !== apex.item("P11_ORDER_BY").getValue()) {
    apex.item("P11_ORDER_BY").setValue(saved);              // the cards refresh in this order
}
$("#P11_ORDER_BY").on("change", () => prefs.setItem("orderBy", apex.item("P11_ORDER_BY").getValue()));
console.log("page loaded - sort:", apex.item("P11_ORDER_BY").getValue(), "- saved:", saved);
// --- after the page loads ---
// === Try it: sort by category, then come back to the page ===
apex.item("P11_ORDER_BY").setValue("CATEGORY_NAME");
await new Promise((resolve) => setTimeout(resolve, 800));
location.reload();
// --- on the next page ---
await new Promise((resolve) => setTimeout(resolve, 800));
console.log("first card:", $("#catalog .a-CardView-title").first().text().trim());
