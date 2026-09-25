// @page item-types
apex.message.showErrors({ type: "error", location: ["inline", "page"], pageItem: "P20_TEXT",
                          message: "Enter a name." });
console.log("errors:", apex.jQuery("#t_Alert_Notification li").length, "- inline:", apex.jQuery("#P20_TEXT_error").text());
apex.message.clearErrors();
console.log("errors:", apex.jQuery("#t_Alert_Notification li").length, "- inline:", apex.jQuery("#P20_TEXT_error").text() || "(none)");
