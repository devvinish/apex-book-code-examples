// @page customers
// @wait 1500
// === Page › Function and Global Variable Declaration ===
// Opens the Customer dialog (page 3) for a customer. A dialog's URL needs a checksum, so
// the server makes it: the Ajax callback PAGE_URL returns apex_page.get_url(...).
async function openCustomer(customerId) {
    const { url } = await apex.server.process("PAGE_URL",
        { x01: "3", x02: "P3_CUSTOMER_ID", x03: String(customerId) });
    apex.navigation.redirect(url);                    // a dialog page's URL opens the dialog
}
// === Try it: open customer 42 from a button, a menu, or a keyboard shortcut ===
await openCustomer(42);
await new Promise((resolve) => setTimeout(resolve, 2500));
const dialog = $("iframe").last()[0].contentWindow;
console.log("dialog:", $(".ui-dialog:visible .ui-dialog-title").text(), "-",
            dialog.apex.item("P3_EMAIL").getValue());
