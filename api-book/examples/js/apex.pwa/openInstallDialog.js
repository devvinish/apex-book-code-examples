// @shot .ui-dialog
apex.pwa.openInstallDialog();
await new Promise((resolve) => setTimeout(resolve, 1000));
console.log("dialog:", apex.jQuery(".ui-dialog:visible .ui-dialog-title").text());
