// @page item-types
// @beforeload
// @wait 1500
apex.jQuery(apex.gPageContext$).on("apexreadyend", function () {
    console.log("page ready; the rich text editor is ready too:",
        apex.item("P20_RICH_TEXT").isReady());
});
