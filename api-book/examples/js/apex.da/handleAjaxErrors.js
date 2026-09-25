const resumeCallback = (errorOccurred) => console.log("resume, errorOccurred:", errorOccurred);
apex.server.process("ORDER_SUMMARY", { x01: "999999" }, {
    error: (jqXHR, textStatus, errorThrown) =>
        apex.da.handleAjaxErrors(jqXHR, textStatus, errorThrown, resumeCallback)
});
await new Promise((resolve) => setTimeout(resolve, 1500));
console.log("alert:", apex.jQuery(".ui-dialog:visible .ui-dialog-content").text().replace(/\s+/g, " ").trim());
setTimeout(() => apex.jQuery(".ui-dialog:visible .ui-dialog-buttonpane button").trigger("click"), 100);
