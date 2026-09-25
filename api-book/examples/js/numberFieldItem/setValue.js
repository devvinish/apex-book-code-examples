// @page item-types
const number = apex.item("P20_NUMBER");
number.setValue(1999.5);                  // a JavaScript number is accepted
console.log(number.getValue());
number.setValue("2500");
console.log(number.getValue(), "->", number.getNativeValue() + 1);
