// @page item-types
const win = apex.navigation.popup({ url: `f?p=${apex.env.APP_ID}:products:${apex.env.APP_SESSION}`, name: "picker" });
await new Promise((resolve) => win.addEventListener("load", resolve));
// in the popup page:
win.apex.navigation.popup.close("P20_TEXT", "BAS-1001");
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("P20_TEXT:", apex.item("P20_TEXT").getValue(), "- popup closed:", win.closed);
