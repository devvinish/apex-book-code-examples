// @page item-types
// @wait 1500
apex.item("P20_TEXT").setValue("");

apex.gPageContext$.on("apexbeforepagesubmit", function (event, request) {
    const text = apex.item("P20_TEXT");
    console.log("before submit, request", request, "- text:", JSON.stringify(text.getValue()));
    // an extra check: an empty text field is not valid
    text.node.setCustomValidity(text.getValue() === "" ? "Enter a product name" : "");
});
apex.page.submit({ request: "SAVE", validate: true });
console.log("page is valid:", apex.item("P20_TEXT").node.checkValidity());
