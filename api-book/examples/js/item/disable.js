// @page item-types
const text = apex.item("P20_TEXT");
text.disable();
console.log("disabled:", text.isDisabled());
text.enable();
console.log("disabled:", text.isDisabled());
