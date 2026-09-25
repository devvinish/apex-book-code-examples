const orders = apex.jQuery("#recent_orders");
orders.on("orbitordershipped", (event, data) => console.log("handler got:", data));
console.log("returned:", apex.event.trigger(orders, "orbitordershipped", { orderId: 2282 }));
// preventDefault does not change the result...
orders.on("orbitbeforecancel", (event) => event.preventDefault());
console.log("returned:", apex.event.trigger(orders, "orbitbeforecancel"));
// ...apex.da.cancel, called by a handler, does
orders.on("orbitbeforedelete", () => apex.da.cancel());
console.log("returned:", apex.event.trigger(orders, "orbitbeforedelete"));
