// @page item-types
apex.gPageContext$.on("apexbeforepagesubmit", (event, request) => {
    if (request === "DELETE") {
        console.log("submit canceled:", request);
        event.preventDefault();                           // the page is not submitted
    }
});
apex.page.submit("DELETE");
console.log("still on page", apex.env.APP_PAGE_ID);
