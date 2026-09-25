// @page item-types
apex.gPageContext$.on("apexbeforepagesubmit", (event, request) => console.log("apexbeforepagesubmit:", request));
apex.gPageContext$.on("apexpagesubmit", (event, request) => console.log("apexpagesubmit:", request));
apex.page.submit({
    request: "APPLY",
    set: { P20_TEXT: "Submitted from JavaScript", P20_NUMBER: "42" },
    showWait: true
});
// --- on the page that the submit loads ---
console.log("P20_TEXT:", apex.item("P20_TEXT").getValue());
console.log("P20_NUMBER:", apex.item("P20_NUMBER").getValue());
