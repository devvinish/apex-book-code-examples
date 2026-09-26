// @page item-types
const text = apex.item("P20_TEXT");
console.log(text.isChanged());
text.setValue("Trail Runner Pack");
console.log(text.isChanged());
console.log("page changed:", apex.page.isChanged());
