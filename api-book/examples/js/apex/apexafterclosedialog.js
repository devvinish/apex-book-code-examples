// @page customers
// @wait 1500
apex.gPageContext$.on("apexafterclosedialog", function (event, data) {
    console.log("returned from the dialog:", data);
    apex.region("customers").refresh();
});

// open the Customer dialog from the first row, then close it from inside the dialog,
// returning two of its items as the Close Dialog process does with "Items to Return"
apex.region("customers").element.find("td a").first()[0].click();
await new Promise((resolve) => setTimeout(resolve, 2500));
const dialog = apex.jQuery("iframe").last()[0].contentWindow;
dialog.apex.navigation.dialog.close(true, {
    P3_COMPANY_NAME: dialog.apex.item("P3_COMPANY_NAME").getValue(),
    P3_EMAIL: dialog.apex.item("P3_EMAIL").getValue()
});
