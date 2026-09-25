// @page item-types
// @wait 1500
apex.gPageContext$.on("apexpagesubmit", function () {
    const text = apex.item("P20_TEXT");
    text.setValue(text.getValue().toUpperCase());
    console.log("sent to the server:", text.getValue());
});
apex.page.submit("SAVE");
