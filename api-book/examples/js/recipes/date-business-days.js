// @page orders
// @wait 800
// === Try it: open an order from the Orders page ===
$("#orders a[href*='order']").first()[0].click();
// --- on the Order page ---
// === Page › Function and Global Variable Declaration ===
// Adds working days to a date: Saturdays and Sundays do not count.
function addBusinessDays(date, days) {
    const result = apex.date.clone(date);
    while (days > 0) {
        apex.date.add(result, 1, apex.date.UNIT.DAY);
        if (result.getDay() !== 0 && result.getDay() !== 6) days--;
    }
    return result;
}
// === Dynamic action on Change of P10_ORDER_DATE › Execute JavaScript Code ===
const ordered = apex.date.parse(apex.item("P10_ORDER_DATE").getValue(), "DD-MON-YYYY");
apex.item("P10_REQUIRED_DATE").setValue(apex.date.format(addBusinessDays(ordered, 5), "DD-MON-YYYY"));
// === Try it: the order date and the new Required By date ===
console.log("ordered:", apex.item("P10_ORDER_DATE").getValue(),
            apex.date.format(ordered, "Day").trim());
console.log("required by:", apex.item("P10_REQUIRED_DATE").getValue(),
            apex.date.format(addBusinessDays(ordered, 5), "Day").trim());
