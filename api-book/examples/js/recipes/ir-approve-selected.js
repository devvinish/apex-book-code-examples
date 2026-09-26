// @page orders
// @wait 1000
// @aftersql update orb_orders set status = 'PENDING_APPROVAL' where order_id in (2259, 2260);
// === Try it: check two orders that are Pending Approval ===
apex.region("orders").setSelectedValues(["2259", "2260"]);
// === Button Approve Selected › Dynamic Action on Click › Execute JavaScript Code ===
const orderIds = apex.region("orders").getSelectedValues();
if (!orderIds.length) {
    apex.message.alert("Select the orders to approve.");
} else {
    apex.item("P8_SELECTED_ORDERS").setValue(orderIds.join(":"));
    // submits the page with the request APPROVE when the user clicks OK
    apex.page.confirm(`Approve ${orderIds.length} order(s)?`, "APPROVE");
}
// === Try it: click OK ===
await new Promise((resolve) => setTimeout(resolve, 400));
console.log("confirm:", $(".ui-dialog:visible .a-AlertMessage-details").text().trim());
$(".ui-dialog:visible .ui-dialog-buttonpane button").last().trigger("click");
// --- on the next page ---
console.log("message:", $("#APEX_SUCCESS_MESSAGE .t-Alert-title").text().trim());
const statusOf = (orderNumber) => $("#orders .a-IRR-table tr")
    .filter((i, row) => row.textContent.includes(orderNumber))
    .find("td").map((i, cell) => cell.textContent.trim()).get()
    .find((text) => /Approv|Pending/.test(text));
console.log("ORD-12259:", statusOf("ORD-12259"), "- ORD-12260:", statusOf("ORD-12260"));
