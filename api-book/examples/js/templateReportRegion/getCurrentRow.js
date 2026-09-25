const orders = apex.region("recent_orders");
orders.element.on("apexcurrentrowchange", () =>
    console.log("apexcurrentrowchange, now", orders.getCurrentRowValue()));
console.log("current row:", orders.getCurrentRowValue());
orders.setCurrentRowValue("2280", true);
console.log("current row:", orders.getCurrentRowValue(),
    "- focus in", document.activeElement.closest("[data-id]").dataset.id);
await new Promise((resolve) => setTimeout(resolve, 300));
orders.setCurrentRow(orders.element.find("[data-id]").last());
const row$ = orders.getCurrentRow();
console.log("current row:", row$.data("id"), row$.find(".t-ContentRow-title").text());
