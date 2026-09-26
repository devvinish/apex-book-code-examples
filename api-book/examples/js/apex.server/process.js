// @page item-types
// ORDER_SUMMARY is an Ajax Callback application process of the API Lab (see the text).
apex.item("P20_TEXT").setValue("sent with the request");
const summary = await apex.server.process("ORDER_SUMMARY",
    { x01: "2282", pageItems: "#P20_TEXT" },
    { loadingIndicator: "#text_items", loadingIndicatorPosition: "append" });
console.log(summary);
