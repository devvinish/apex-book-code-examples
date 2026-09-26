// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const orders = apex.model.get("orbitOrders");
const chart = orders.transform({
    template: [{
        path: "items",
        filter: (model, record) => model.getValue(record, "STATUS") === "APPROVED",
        item: { label: "CUSTOMER", value: (model, record) => Number(model.getValue(record, "TOTAL")) }
    }, {
        path: "statuses",
        uniqueIndexField: "STATUS",
        item: "STATUS"
    }]
});
console.log(JSON.stringify(chart, null, 1));
