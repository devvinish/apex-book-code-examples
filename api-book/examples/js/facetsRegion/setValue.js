// @page products
const search = apex.region("product_search");
const products = apex.region("products");
const done = () => new Promise((resolve) => setTimeout(resolve, 2000));   // report and counts
search.on("facetschange", () => console.log("facetschange"));

apex.item("P4_CATEGORY_ID").setValue("I9:11");            // Camp Kitchen and Backpacks
await done();
console.log("category:", apex.item("P4_CATEGORY_ID").getValue(), "->", search.getTotalResourceCount(), "products");
apex.item("P4_PRICE").setValue("50|150");                 // from 50 to 150
await done();
console.log("and price 50-150 ->", search.getTotalResourceCount(), "products");
