// @page orders
// @wait 1000
// === Try it: open an order from the Orders page ===
$("#orders a[href*='order']").first()[0].click();
// --- on the Order page ---
// === Page › Execute when Page Loads ===
const lines = apex.region("order_lines").call("getViews", "grid").model;
// "$179.99" → 179.99
const num = (value) => apex.locale.toNumber(value || "0", "FML999G999G990D00") || 0;

function updateOrderTotal() {
    let total = 0;
    lines.forEach((record, index, id) => {
        if (lines.getRecordMetadata(id).deleted) return;
        total += num(lines.getValue(record, "QUANTITY")) * num(lines.getValue(record, "UNIT_PRICE"))
               * (1 - num(lines.getValue(record, "DISCOUNT_PCT")) / 100);
    });
    // the order's own discount
    total = total * (1 - num(apex.item("P10_DISCOUNT_PCT").getValue()) / 100);
    apex.item("P10_ORDER_TOTAL").setValue(apex.locale.formatNumber(total, "FML999G999G990D00"));
}

lines.subscribe({
    onChange: function(type, change) {
        if ((type === "set" && ["QUANTITY", "UNIT_PRICE", "DISCOUNT_PCT"].includes(change.field)) ||
            ["insert", "delete", "revert"].includes(type)) {
            updateOrderTotal();
        }
    }
});
$("#P10_DISCOUNT_PCT").on("change", updateOrderTotal);
// === Try it: change the quantity of the first line, delete the second, and change the discount ===
console.log("total:", apex.item("P10_ORDER_TOTAL").getValue());
const records = [];
lines.forEach((record) => records.push(record));
lines.setValue(records[0], "QUANTITY", "12");
console.log("line 1 quantity 10 → 12:", apex.item("P10_ORDER_TOTAL").getValue());
lines.deleteRecords([records[1]]);
console.log("line 2 deleted:", apex.item("P10_ORDER_TOTAL").getValue());
apex.item("P10_DISCOUNT_PCT").setValue("10");
console.log("order discount 15% → 10%:", apex.item("P10_ORDER_TOTAL").getValue());
