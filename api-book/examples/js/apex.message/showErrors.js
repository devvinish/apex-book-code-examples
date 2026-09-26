// @page item-types
// @shot clip 0,0,1280,330
apex.message.showErrors([
    { type: "error", location: "page", message: "The order could not be saved." },
    { type: "error", location: ["inline", "page"], pageItem: "P20_TEXT",
      message: "Enter a name of at most 30 characters." }
]);
console.log("page errors:", apex.jQuery("#t_Alert_Notification li").length);
console.log("inline error:", apex.jQuery("#P20_TEXT_error").text());
