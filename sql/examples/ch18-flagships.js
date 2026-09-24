var grid  = apex.region("stores").widget().interactiveGrid("getViews", "grid"),
    model = grid.model,
    names = [];

model.forEach(function (record) {
    var flagship = model.getValue(record, "FLAGSHIP");   // { v: true, d: "On" }
    if (flagship.v === true) {
        names.push(model.getValue(record, "STORE_NAME"));
    }
});

apex.message.alert("Flagship stores: " + names.join(", "));
