// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const orders = apex.model.get("orbitOrders");
orders.setValidity("error", "2279", "TOTAL", "The total must not exceed the credit limit.");
orders.setValidity("warning", "2278", null, "Customer on hold.");
console.log("hasErrors:", orders.hasErrors(), "- errors:", orders.getErrors().map((m) => orders.getRecordId(m.record)));
const meta = orders.getRecordMetadata("2279");
console.log("record error:", !!meta.error, "- field:", meta.fields.TOTAL);
orders.setValidity("valid", "2279", "TOTAL");
console.log("after valid:", orders.hasErrors());
orders.setDisabledState("2280", true);
orders.setHiddenState("2277", true);
console.log("disabled:", orders.isDisabled(orders.getRecord("2280")), "- hidden:", orders.getRecordMetadata("2277").hidden);
const m2 = orders.getRecordMetadata("2282");
m2.highlight = "orbit-urgent";                             // metadata changed by your code...
orders.metadataChanged("2282", null, "highlight");         // ...must be announced
console.log("highlight:", orders.getRecordMetadata("2282").highlight);
