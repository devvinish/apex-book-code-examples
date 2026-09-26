// @page item-types
// @wait 1500
apex.gPageContext$.on("apexpagesubmit", function (event, request) {
    console.log("submitting with request", request);
});
apex.submit({ request: "APPLY_FILTER", showWait: true });
