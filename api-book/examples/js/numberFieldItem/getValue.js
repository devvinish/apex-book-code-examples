// @page item-types
const number = apex.item("P20_NUMBER");
console.log(JSON.stringify(number.getValue()));   // as formatted in the field
console.log(number.getNativeValue());
