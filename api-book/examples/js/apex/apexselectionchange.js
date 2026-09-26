// @page home
// @wait 1200
// @shot #recent_orders .t-Region-body
const orders = apex.region("recent_orders");
orders.element.on("apexselectionchange", function (event, data) {
    console.log("selected orders:", data.selectedValues);
});
const firstTwo = orders.element.find("[data-id]").slice(0, 2)
    .map((i, row) => row.getAttribute("data-id")).get();
orders.setSelectedValues(firstTwo, true);
