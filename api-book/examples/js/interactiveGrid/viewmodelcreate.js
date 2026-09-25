// @page stores
// @beforeload
apex.jQuery(document).on("interactivegridviewmodelcreate", (event, data) => {
    console.log("viewmodelcreate:", event.target.id, "- view:", data.viewId, "- model:", data.model.modelId());
    // subscribe here to see every change of the model
    data.model.subscribe({ onChange: (type) => { if (type === "set") console.log("model: set"); } });
});
apex.jQuery(document).on("interactivegridreportchange", (event) => console.log("reportchange:", event.target.id));
