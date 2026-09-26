// @page home
// @wait 1200
const orders = apex.region("recent_orders");
orders.element.on("apexcurrentrowchange", function (event, data) {
    console.log("current order:", data.currentValue);
});
const third = orders.element.find("[data-id]").eq(2).attr("data-id");
orders.setCurrentRowValue(third, true);
