// @page item-types
apex.page.confirm("Delete the selected documents?", {
    request: "DELETE",
    set: { P20_HIDDEN: "42" }
});
await new Promise((resolve) => setTimeout(resolve, 500));   // the dialog opens asynchronously
console.log("dialog:", apex.jQuery(".ui-dialog:visible .ui-dialog-content").text().replace(/\s+/g, " ").trim());
