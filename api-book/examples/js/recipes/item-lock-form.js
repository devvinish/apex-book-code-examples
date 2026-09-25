// @page orders
// @shot clip 0,168,1280,262
// @wait 800
// === Try it: open an order from the Orders page ===
$("#orders a[href*='order']").first()[0].click();
// --- on the Order page ---
// === Page › Function and Global Variable Declaration ===
// A shipped, delivered, or cancelled order can no longer be edited; only its status can change.
function lockOrder() {
    const locked = ["SHIPPED", "DELIVERED", "CANCELLED"].includes(apex.item("P10_STATUS").getValue());
    $("#order_form [id]").each((i, element) => {
        const name = element.id;
        if (/^P10_/.test(name) && name !== "P10_STATUS" && apex.item.isItem(name)) {
            if (locked) apex.item(name).disable(); else apex.item(name).enable();
        }
    });
    $("#save_order").toggle(!locked);                         // the Apply Changes button
    const grid = apex.region("order_lines").call("getActions");
    if (locked) { grid.set("edit", false); grid.disable("edit"); } else grid.enable("edit");
}
// === Page › Execute when Page Loads, and a dynamic action on Change of P10_STATUS ===
lockOrder();
// === Try it: set the status to Delivered ===
apex.item("P10_STATUS").setValue("DELIVERED");
lockOrder();
console.log("disabled:", ["P10_ORDER_DATE", "P10_CUSTOMER_ID", "P10_DISCOUNT_PCT", "P10_NOTES"]
    .filter((name) => apex.item(name).isDisabled()).join(", "));
console.log("Apply Changes visible:", $("#save_order").is(":visible"),
            "- grid editable:", !apex.region("order_lines").call("getActions").lookup("edit").disabled);
