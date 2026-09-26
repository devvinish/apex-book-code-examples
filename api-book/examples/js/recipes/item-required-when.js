// @page orders
// @wait 1200
// @shot clip 0,488,1280,108
// === Try it: open an order from the Orders page ===
$("#orders a[href*='order']").first()[0].click();
// --- on the Order page ---
// === Page › Execute when Page Loads ===
apex.gPageContext$.on("apexbeforepagesubmit", function(event, request) {
    if (request !== "SAVE") return;
    apex.message.clearErrors();
    if (apex.item("P10_STATUS").getValue() === "SHIPPED" && apex.item("P10_SHIPPED_DATE").isEmpty()) {
        apex.message.showErrors([{
            type: "error",
            location: ["inline", "page"],
            pageItem: "P10_SHIPPED_DATE",
            message: "Enter the date the order was shipped.",
            unsafe: false
        }]);
        apex.event.gCancelFlag = true;                          // the page is not submitted
    }
});
// === Try it: set the status to Shipped, leave Shipped Date empty, and click Apply Changes ===
apex.item("P10_STATUS").setValue("SHIPPED");
apex.item("P10_SHIPPED_DATE").setValue("");
$("button").filter((i, b) => b.textContent.trim() === "Apply Changes").trigger("click");
await new Promise((resolve) => setTimeout(resolve, 800));
console.log("submitted:", apex.page.isChanged() ? "no, the changes are still on the page" : "yes");
console.log("inline error:", $("#P10_SHIPPED_DATE_error").text());
