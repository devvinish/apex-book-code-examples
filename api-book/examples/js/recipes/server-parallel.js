// @page home
// === Page › Function and Global Variable Declaration ===
// Gets the summaries of several orders at the same time and waits for all of them.
async function orderSummaries(orderIds) {
    const answers = await Promise.allSettled(
        orderIds.map((id) => apex.server.process("ORDER_SUMMARY", { x01: id })));
    return answers.map((answer, i) => answer.status === "fulfilled"
        ? answer.value
        : { orderId: orderIds[i], error: answer.reason.responseJSON?.error });
}
// === Try it: the orders selected in Recent Orders, and one that does not exist ===
apex.region("recent_orders").setSelectedValues(["2277", "2276"]);
const ids = [...apex.region("recent_orders").getSelectedValues(), "99999"];
const summaries = await orderSummaries(ids);
summaries.forEach((s) =>
    console.log(s.error ? `${s.orderId}: ${s.error}` : `${s.orderNumber}: ${s.total}`));
const total = summaries.filter((s) => !s.error).reduce((sum, s) => sum + s.total, 0);
console.log("total:", apex.locale.formatNumber(total, "FML999G999G990D00"));
