// @page products
const products = apex.region("products");
products.element.on("apexafterrefresh", () => console.log("apexafterrefresh"));
const result = products.refresh();
console.log("refresh returned:", typeof result.then === "function" ? "a promise" : result);
await result;
console.log("refresh done:", products.element.find("tbody tr").length, "rows");
