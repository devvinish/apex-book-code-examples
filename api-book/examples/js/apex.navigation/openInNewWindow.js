// @page home
const win = apex.navigation.openInNewWindow(`f?p=${apex.env.APP_ID}:stores:${apex.env.APP_SESSION}`, "stores");
await new Promise((resolve) => win.addEventListener("load", resolve));
console.log("window:", win.name, "- page", win.apex.env.APP_PAGE_ID, "- opener:", win.opener === window);
const again = apex.navigation.openInNewWindow(`f?p=${apex.env.APP_ID}:orders:${apex.env.APP_SESSION}`, "stores");
console.log("reused:", again === win);
win.close();
