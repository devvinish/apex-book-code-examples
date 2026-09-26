const orders = apex.region("recent_orders");
const ids = () => orders.element.find("[data-id]").map((i, e) => e.dataset.id).get().join(" ");
const pause = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
console.log("page 1:", ids());
console.log("nextPage:", orders.nextPage());
await pause(1500);                                        // the next page is fetched from the server
console.log("page 2:", ids());
console.log("previousPage:", orders.previousPage());
await pause(1500);
console.log("page 1:", ids());
