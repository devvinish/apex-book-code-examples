// @page item-types
const text = apex.item("P20_TEXT");
text.node.required = true;
text.setValue("");
const validity = text.getValidity();
console.log("valid:", validity.valid, "- valueMissing:", validity.valueMissing);
