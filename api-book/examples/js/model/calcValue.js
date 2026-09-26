apex.model.create("orbitLines", {
    editable: true, identityField: "LINE_ID", paginationType: "none",
    fields: {
        LINE_ID: {}, PRODUCT: {}, QUANTITY: {}, UNIT_PRICE: {},
        LINE_TOTAL: {
            dependsOn: ["QUANTITY", "UNIT_PRICE"],
            calcValue: (argsArray, model, record) =>
                (Number(model.getValue(record, "QUANTITY")) * Number(model.getValue(record, "UNIT_PRICE"))).toFixed(2)
        }
    }
}, [{ LINE_ID: "1", PRODUCT: "Trailblazer 2-Person Tent", QUANTITY: "1", UNIT_PRICE: "349.99", LINE_TOTAL: "349.99" }]);
const lines = apex.model.get("orbitLines");
lines.setRecordValue("1", "QUANTITY", "3");
console.log("LINE_TOTAL:", lines.getRecordValue("1", "LINE_TOTAL"));
