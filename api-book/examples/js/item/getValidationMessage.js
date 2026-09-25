// @page item-types
const text = apex.item("P20_TEXT");
text.node.required = true;
text.setValue("");
console.log(text.getValidationMessage());

// a message of your own, in the attribute that APEX reads
text.element.attr("data-valid-message", "Enter the product name, for example Trail Runner Pack.");
console.log(text.getValidationMessage());
