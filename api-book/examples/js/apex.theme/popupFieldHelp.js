// @page item-types
// @shot .ui-dialog
apex.theme.popupFieldHelp({
    title: "Text Field",
    helpText: "<p>Enter up to <strong>100 characters</strong>. The value is saved in upper case.</p>"
});
await new Promise((resolve) => setTimeout(resolve, 800));
console.log("help dialog:", apex.jQuery(".ui-dialog-title:visible").text());
