const orders = apex.region("recent_orders");
orders.element.on("apexselectionchange", () =>
    console.log("apexselectionchange:", orders.getSelectedValues()));
const count = orders.setSelectedValues(["2280", "2278", "9999"]);
console.log("rows selected:", count);
console.log(orders.getSelectedValues());
