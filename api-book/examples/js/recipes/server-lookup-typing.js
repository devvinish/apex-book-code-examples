// @page item-types
// @wait 1500
// === Page › Execute when Page Loads ===
// Looks up the order whose ID the user types into P20_TEXT, 400 ms after the last key.
const lookUpOrder = apex.util.debounce(() => {
    const orderId = apex.item("P20_TEXT").getValue().trim();
    apex.message.clearErrors();
    if (!orderId) return;
    apex.server.process("ORDER_SUMMARY", { x01: orderId },
                        { queue: { name: "order-lookup", action: "replace" } })  // only the last one
        .then((order) => {
            const total = apex.locale.formatNumber(order.total, "FML999G999G990D00");
            apex.item("P20_DISPLAY_ONLY")
                .setValue(`${order.orderNumber} · ${order.customer} · ${total}`);
            console.log("found:", apex.item("P20_DISPLAY_ONLY").getValue());
        })
        .catch((jqXHR) => {
            if (jqXHR.statusText === "abort") return;               // replaced by a newer request
            apex.item("P20_DISPLAY_ONLY").setValue("");
            apex.message.showErrors({ type: "error", location: "inline", pageItem: "P20_TEXT",
                message: jqXHR.responseJSON?.error || "The lookup failed.", unsafe: false });
            console.log("error:", $("#P20_TEXT_error").text());
        });
}, 400);
$("#P20_TEXT").on("input", lookUpOrder);
// === Try it: type 2277 one key at a time, then 99999 ===
const type = async (text) => {
    for (let i = 1; i <= text.length; i++) {
        $("#P20_TEXT").val(text.slice(0, i)).trigger("input");
        await new Promise((resolve) => setTimeout(resolve, 120));       // a fast typist
    }
    await new Promise((resolve) => setTimeout(resolve, 1500));
};
await type("2277");
await type("99999");
