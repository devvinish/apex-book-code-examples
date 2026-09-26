// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const orders = apex.model.get("orbitOrders");
console.log("modelId:", orders.modelId(), "- editable:", orders.getOption("editable"),
            "- pageSize:", orders.getOption("pageSize"), "- genIdPrefix:", orders.getOption("genIdPrefix"));
orders.setOption("genIdPrefix", "new");
console.log("new record id:", orders.insertNewRecord());
console.log("field key:", orders.getFieldKey("CUSTOMER"), "- metadata:", orders.getFieldMetadata("STATUS"));
console.log("identity:", orders.isIdentityField("ORDER_ID"), orders.isIdentityField("STATUS"));
