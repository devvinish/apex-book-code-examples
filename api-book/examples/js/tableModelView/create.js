// @page product-catalog
// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
// @shot #orbit_order_list
// A tableModelView of your own: templates render the records of a model.
apex.jQuery(`<div id="orbit_order_list"></div>`).insertBefore("#catalog").tableModelView({
    modelName: "orbitOrders",
    beforeTemplate: `<ul class="orbit-orders">`,
    recordTemplate: `<li #APEX$ROW_IDENTIFICATION# class="orbit-order">#APEX$SELECTOR# <b>&ORDER_NUMBER.</b> &CUSTOMER. (&STATUS.)</li>`,
    afterTemplate: `</ul>`,
    itemNavigationMode: "select",
    itemSelector: ".orbit-order",
    multiple: true,
    footer: true,
    entityTitleSingular: "order", entityTitlePlural: "orders",
    pagination: { scroll: false, showRange: false }
});
const view$ = apex.jQuery("#orbit_order_list");
view$.on("tablemodelviewselectionchange", () => console.log("selectionchange:", view$.tableModelView("getSelectedValues")));
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("items:", view$.find(".orbit-order").length);
console.log("setSelectedValues:", view$.tableModelView("setSelectedValues", ["2279", "2277"]));
await new Promise((resolve) => setTimeout(resolve, 200));
view$.tableModelView("setCurrentItemValue", "2278", true);
console.log("current:", view$.tableModelView("getCurrentItemValue"));
