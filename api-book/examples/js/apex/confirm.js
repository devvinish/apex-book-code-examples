// @page item-types
// @shot .ui-dialog:visible
apex.confirm("Discard the changes on this page?", "DISCARD");
await new Promise((resolve) => setTimeout(resolve, 400));
console.log("dialog open:", apex.jQuery(".ui-dialog:visible").length === 1);
