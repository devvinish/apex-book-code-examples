// @page item-types
const number = apex.item("P20_NUMBER");
console.log(number.getValue(), number.isChanged());
number.setValue("1250");                  // the same number, unformatted
console.log(number.getValue(), number.isChanged());
number.setValue("1300");
console.log(number.getValue(), number.isChanged());
