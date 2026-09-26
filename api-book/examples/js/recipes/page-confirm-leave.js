// @page orders
// @wait 800
// === Try it: open an order from the Orders page ===
$("#orders a[href*='order']").first()[0].click();
// --- on the Order page ---
// === Button Back to Orders › Dynamic Action on Click › Execute JavaScript Code ===
function backToOrders() {
    const leave = () =>
        apex.navigation.redirect(`f?p=${apex.env.APP_ID}:orders:${apex.env.APP_SESSION}`);
    if (!apex.page.isChanged()) {
        leave();
    } else {
        apex.message.confirm("This order has unsaved changes. Leave without saving?",
                             (okPressed) => { if (okPressed) leave(); });
    }
}
// === Try it: change the notes, click the button, and click Cancel ===
apex.item("P10_NOTES").setValue("Call before delivery.");
backToOrders();
await new Promise((resolve) => setTimeout(resolve, 500));
console.log("confirm:", $(".ui-dialog:visible .a-AlertMessage-details").text().trim());
$(".ui-dialog:visible .ui-dialog-buttonpane button").first().trigger("click");   // Cancel
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("still on page", apex.env.APP_PAGE_ID, "- notes:", apex.item("P10_NOTES").getValue());
