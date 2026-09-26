// @page item-types
const many = apex.item("P20_SELECT_MANY");
many.setValue([]);
many.addValue("2");
many.addValue("4");
console.log(many.getValue());
