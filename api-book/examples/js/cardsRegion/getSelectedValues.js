// @page product-catalog
const catalog = apex.region("catalog");
console.log("itemNavigationMode:", catalog.call("option", "itemNavigationMode"));
console.log("getSelectedValues:", catalog.getSelectedValues());
console.log("setSelectedValues:", catalog.setSelectedValues(["39"]));
console.log("getCurrentItemValue:", catalog.getCurrentItemValue());
