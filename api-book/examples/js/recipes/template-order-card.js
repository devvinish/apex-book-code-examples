// @page home
// @wait 1500
// @shot #welcome
// === Page › Function and Global Variable Declaration ===
const orderCard = `
  <h3 class="u-margin-none">&ORDER_NUMBER. · &CUSTOMER.</h3>
  <p class="u-margin-none">
    {case STATUS/}
      {when APPROVED/}<span class="u-success-text">Approved</span>
      {when PENDING_APPROVAL/}<span class="u-warning-text">Waiting for approval</span>
      {otherwise/}&STATUS.
    {endcase/}
    · &LINES. lines · <strong>&TOTAL.</strong>
  </p>`;

// Shows the summary of an order in the Welcome region.
async function showOrderCard(orderId) {
    const order = await apex.server.process("ORDER_SUMMARY", { x01: orderId });
    const html = apex.util.applyTemplate(orderCard, {
        extraSubstitutions: {                                // values are escaped by default
            ORDER_NUMBER: order.orderNumber, CUSTOMER: order.customer, STATUS: order.status,
            LINES: String(order.lines),
            TOTAL: apex.locale.formatNumber(order.total, "FML999G999G990D00")
        }
    });
    apex.region("welcome").element.find(".t-Region-body").html(html);
}
// === Page › Execute when Page Loads ===
apex.region("recent_orders").element.on("apexcurrentrowchange", () => {
    showOrderCard(apex.region("recent_orders").getCurrentRowValue());
});
// === Try it: click the first order in Recent Orders ===
apex.region("recent_orders").setCurrentRowValue("2277");
await new Promise((resolve) => setTimeout(resolve, 1200));
const body = apex.region("welcome").element.find(".t-Region-body")[0];
console.log(body.innerText.trim().replace(/\s*\n\s*/g, " | "));
