// @page products
const search = apex.region("product_search");
const pause = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
search.call("option", { batch: true, externalApply: true });
search.refreshView();
const box = search.widget().find(".a-FS-control").first().find("input[value='11']");
box.prop("checked", true).trigger("change");              // as if the user checked Backpacks
await pause(3000);
console.log("before apply:", apex.item("P4_CATEGORY_ID").getValue(), "-", search.getTotalResourceCount(), "products");
search.apply();
await pause(3000);
console.log("after apply: ", apex.item("P4_CATEGORY_ID").getValue(), "-", search.getTotalResourceCount(), "products");
