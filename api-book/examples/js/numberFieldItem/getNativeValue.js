// @page item-types
const number = apex.item("P20_NUMBER");
console.log(number.getValue(), typeof number.getValue());
console.log(number.getNativeValue(), typeof number.getNativeValue());
number.setValue("abc");
console.log(number.getNativeValue());
