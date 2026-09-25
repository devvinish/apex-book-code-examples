apex.model.create("orbitGuarded", {
    editable: true, identityField: "ORDER_ID", paginationType: "none",
    fields: { ORDER_ID: {}, STATUS: {} },
    // shipped and cancelled orders cannot be edited or deleted
    check: (result, operation, record) => {
        if (record && ["canEdit", "canDelete"].includes(operation)) {
            return result && !["SHIPPED", "CANCELLED"].includes(record.STATUS);
        }
        return result;
    }
}, [{ ORDER_ID: "2282", STATUS: "SHIPPED" }, { ORDER_ID: "2279", STATUS: "APPROVED" }]);
const m = apex.model.get("orbitGuarded");
for (const id of ["2282", "2279"]) {
    const r = m.getRecord(id);
    console.log(id, "edit:", m.allowEdit(r), "- delete:", m.allowDelete(r), "- drag:", m.allowDrag(r));
}
console.log("add:", m.allowAdd(), "- check canAdd:", m.check("canAdd"));
console.log("drag operations:", m.dragOperations([m.getRecord("2279")]));
