// @page home
// @wait 500
// === Page › Function and Global Variable Declaration ===
// Calls the ORDER_SUMMARY Ajax callback with a spinner over a region until the answer arrives.
function loadSummary(orderId, regionId) {
    return apex.server.process("ORDER_SUMMARY", { x01: orderId, x02: 2 }, {   // x02: wait 2 seconds
        loadingIndicator: apex.region(regionId).element,
        loadingIndicatorPosition: "centered"
    });
}
// === Try it: load the summary of order 2277 over the Recent Orders region ===
const request = loadSummary(2277, "recent_orders");
await new Promise((resolve) => setTimeout(resolve, 500));
console.log("spinner while waiting:", $("#recent_orders .u-Processing").length);
const summary = await request;
console.log(summary.orderNumber, summary.customer, summary.total);
console.log("spinner afterwards:", $("#recent_orders .u-Processing").length);
