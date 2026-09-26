// @page item-types
const win = apex.navigation.popup({
    url: `f?p=${apex.env.APP_ID}:products:${apex.env.APP_SESSION}`,
    name: "products", width: 800, height: 600
});
await new Promise((resolve) => win.addEventListener("load", resolve));
console.log("popup window:", win.name, "- page", win.apex.env.APP_PAGE_ID);
win.close();
