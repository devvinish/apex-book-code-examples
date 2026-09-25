// @page customers
// @wait 1500
apex.gPageContext$.on("apexafterclosecanceldialog", function (event, data) {
    console.log("dialog page", data.dialogPageId, "ended with", data.closeAction);
});

// open the Customer dialog, then cancel it as the Close (X) button does
apex.region("customers").element.find("td a").first()[0].click();
await new Promise((resolve) => setTimeout(resolve, 2500));
const dialog = apex.jQuery("iframe").last()[0].contentWindow;
dialog.apex.navigation.dialog.cancel(true);
