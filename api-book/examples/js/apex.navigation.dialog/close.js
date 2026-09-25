// @page customers
// A dialog URL must come from the server, with its checksums: take the one of the
// report's link to the first customer.
const link = apex.jQuery("#customers a[href*='dialog-open']").first().attr("href");
const url = new URLSearchParams(link.split("?")[1]).get("url");
apex.jQuery("#customers").on("apexafterclosedialog", (event, data) =>
    console.log("apexafterclosedialog:", data.dialogPageId, data.P3_EMAIL));
apex.navigation.dialog(url, { title: "Customer", modal: true }, "", "#customers");
await new Promise((resolve) => setTimeout(resolve, 3000));
// in the dialog page (here reached through its iframe):
const dialogWindow = document.querySelector(".ui-dialog iframe").contentWindow;
dialogWindow.apex.navigation.dialog.close(true, ["P3_EMAIL"]);
await new Promise((resolve) => setTimeout(resolve, 500));
console.log("dialogs open:", apex.jQuery(".ui-dialog:visible").length);
