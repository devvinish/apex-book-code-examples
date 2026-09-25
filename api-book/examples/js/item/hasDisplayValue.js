// @page item-types
const text = apex.item("P20_TEXT");
console.log("text shows a value:", text.hasDisplayValue());
text.setValue("");
console.log("after clearing:", text.hasDisplayValue(), "- empty:", text.isEmpty());
