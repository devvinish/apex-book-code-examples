// @page products
const search = apex.region("product_search");
let requests = 0;
apex.jQuery(document).on("ajaxSend", () => requests++);   // count the calls to the server
console.log("fetchCounts returned:", search.fetchCounts());
await new Promise((resolve) => setTimeout(resolve, 1500));
console.log("server requests:", requests, "- total:", search.getTotalResourceCount());
