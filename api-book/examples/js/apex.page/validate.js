// @page item-types
// @shot clip 0,0,1280,330
const text = apex.item("P20_TEXT").node;
text.required = true;                                     // an HTML 5 constraint
text.value = "";
console.log("valid:", apex.page.validate());
text.value = "Orbit";
apex.message.clearErrors();
console.log("valid:", apex.page.validate());
text.value = "";
apex.page.validate();                                     // shows the error again for the screenshot
