// @page orders
// @wait 800
// @shot clip 0,488,1280,108
// === Try it: open an order from the Orders page ===
$("#orders a[href*='order']").first()[0].click();
// --- on the Order page ---
// === Page › Function and Global Variable Declaration ===
// Required By must be on or after the order date, and no more than 60 days later.
function checkRequiredDate() {
    const { UNIT } = apex.date;
    const mask = "DD-MON-YYYY";
    let ordered, required;
    try {
        ordered  = apex.date.parse(apex.item("P10_ORDER_DATE").getValue(), mask);
        required = apex.date.parse(apex.item("P10_REQUIRED_DATE").getValue(), mask);
    } catch (e) {
        return true;                          // empty or not a date: Value Required handles that
    }
    let problem = null;
    if (apex.date.isBefore(required, ordered, UNIT.DAY)) {
        problem = "Required By cannot be before the order date.";
    } else if (apex.date.isAfter(required, apex.date.add(apex.date.clone(ordered), 60, UNIT.DAY),
                                 UNIT.DAY)) {
        problem = "Required By must be within 60 days of the order date.";
    }
    apex.message.clearErrors();
    if (problem) {
        apex.message.showErrors({ type: "error", location: "inline", pageItem: "P10_REQUIRED_DATE",
                                  message: problem, unsafe: false });
    }
    return !problem;
}
// === Dynamic action on Change of P10_ORDER_DATE, P10_REQUIRED_DATE › Execute JavaScript Code ===
checkRequiredDate();
// === Try it: three dates for an order of 23-SEP-2026 ===
for (const date of ["20-SEP-2026", "30-DEC-2026", "15-OCT-2026"]) {
    apex.item("P10_REQUIRED_DATE").setValue(date);
    console.log(date, "→", checkRequiredDate() ? "valid" : $("#P10_REQUIRED_DATE_error").text());
}
apex.item("P10_REQUIRED_DATE").setValue("30-DEC-2026");      // (for the picture)
checkRequiredDate();
