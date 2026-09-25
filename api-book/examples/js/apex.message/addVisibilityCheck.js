// @page item-types
// A region plug-in that hides its content would register a check like this one.
apex.message.addVisibilityCheck((id) => console.log("make visible:", id));
apex.message.showErrors({ type: "error", location: ["inline", "page"], pageItem: "P20_TEXT",
                          message: "Enter a name." });
apex.jQuery("#t_Alert_Notification a").first().trigger("click");   // the user clicks the error
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("focus in:", document.activeElement.id);
