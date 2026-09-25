// @page customers
// @wait 2500
// @aftersql update orb_customers set phone = '(457) 237-9028' where customer_id = 42;
// === Page › Execute when Page Loads (or a Dialog Closed dynamic action on the region) ===
apex.region("customers").element.on("apexafterclosedialog", (event, data) => {
    console.log("dialog closed:", data);
    if (data.dialogPageId === 3 && data.closeAction === "close") {
        apex.region("customers").refresh();
        apex.message.showPageSuccess("The customer was saved.");
    }
});
// === Try it: edit the first customer's phone in the dialog and click Apply Changes ===
apex.region("customers").element.find("td a").first()[0].click();
await new Promise((resolve) => setTimeout(resolve, 2500));
const dialog = $("iframe").last()[0].contentWindow;
dialog.apex.item("P3_PHONE").setValue("(457) 237-9000");
dialog.$("button").filter((i, button) => button.textContent.trim() === "Apply Changes")
    .trigger("click");
await new Promise((resolve) => setTimeout(resolve, 4000));
console.log("message:", $("#APEX_SUCCESS_MESSAGE .t-Alert-title").text().trim());
console.log("in the report:", $("#customers td")
    .filter((i, cell) => cell.textContent.includes("237-90"))
    .map((i, cell) => cell.textContent.trim()).get());
