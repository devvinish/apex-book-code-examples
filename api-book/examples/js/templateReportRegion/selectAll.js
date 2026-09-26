const orders = apex.region("recent_orders");
orders.selectAll();
console.log("after selectAll:", orders.getSelectedValues());
orders.setSelectedValues(orders.element.find("[data-id]").map((i, e) => e.dataset.id).get());
console.log("after setSelectedValues:", orders.getSelectedValues().length, "rows");
