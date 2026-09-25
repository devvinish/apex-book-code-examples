// @page home
console.log("leaving page", apex.env.APP_PAGE_ID);
apex.navigation.redirect(`f?p=${apex.env.APP_ID}:customers:${apex.env.APP_SESSION}`);
// --- on the Customers page ---
console.log("now on page", apex.env.APP_PAGE_ID);
