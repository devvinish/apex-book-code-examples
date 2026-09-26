// @page item-types
const many = apex.item("P20_SELECT_MANY");
many.setValue(["1", "2", "4"]);
many.removeValue("2");
console.log(many.getValue());
