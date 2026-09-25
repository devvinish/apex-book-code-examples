apex.model.create("orbitFiltered", {
    identityField: "ORDER_ID", paginationType: "none",
    fields: { ORDER_ID: {}, STATUS: {} },
    visibilityFilter: (model, record, context) => !context.status || model.getValue(record, "STATUS") === context.status,
    visibilityFilterContext: {}
}, [{ ORDER_ID: "2282", STATUS: "SHIPPED" }, { ORDER_ID: "2280", STATUS: "CANCELLED" }, { ORDER_ID: "2279", STATUS: "APPROVED" }]);
const m = apex.model.get("orbitFiltered");
const visible = () => { const ids = []; m.forEach((r, i, id) => { if (!m.getRecordMetadata(id).hidden) ids.push(id); }); return ids.join(" "); };
console.log("all:", visible());
m.updateVisibility({ status: "APPROVED" });
console.log("APPROVED:", visible());
