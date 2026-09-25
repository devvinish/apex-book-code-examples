// @page item-types
const number = apex.item("P20_NUMBER");      // format mask 999G999G990D00
console.log(number.displayValueFor("1250"));
console.log(number.displayValueFor("1234567.5"));
