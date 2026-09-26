apex.model.create("orbitOrders", {
    shape: "table",
    editable: true,
    identityField: "ORDER_ID",
    paginationType: "none",
    fields: {
        ORDER_ID:     { dataType: "NUMBER", readonly: true },
        ORDER_NUMBER: {},
        CUSTOMER:     {},
        STATUS:       { defaultValue: "NEW" },
        TOTAL:        { dataType: "NUMBER" }
    }
}, [
    { ORDER_ID: "2282", ORDER_NUMBER: "ORD-12283", CUSTOMER: "Wildflower Travel Co.", STATUS: "SHIPPED", TOTAL: "463.21" },
    { ORDER_ID: "2280", ORDER_NUMBER: "ORD-12280", CUSTOMER: "Linda Kim", STATUS: "CANCELLED", TOTAL: "69.98" },
    { ORDER_ID: "2279", ORDER_NUMBER: "ORD-12279", CUSTOMER: "Matthew Jones", STATUS: "APPROVED", TOTAL: "1329.95" },
    { ORDER_ID: "2278", ORDER_NUMBER: "ORD-12278", CUSTOMER: "Linda Lopez", STATUS: "APPROVED", TOTAL: "1030.69" },
    { ORDER_ID: "2277", ORDER_NUMBER: "ORD-12277", CUSTOMER: "Prairie Travel Co.", STATUS: "APPROVED", TOTAL: "11495.93" }
]);
const orders = apex.model.get("orbitOrders");
console.log("model:", orders.modelId(), "- records:", orders.getTotalRecords(), "- shape:", orders.getOption("shape"));
console.log("list:", apex.model.list(true).filter((id) => /orbit/.test(id)));
