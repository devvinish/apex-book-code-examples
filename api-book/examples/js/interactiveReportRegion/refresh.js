// @page customers
const customers = apex.region("customers");
const range = () => customers.element.find(".a-IRR-pagination-label").first().text().replace(/\s+/g, " ").trim();
const refreshed = () => new Promise((resolve) => customers.element.one("apexafterrefresh", resolve));
const next = () => customers.element.find(".a-IRR-button--pagination[aria-label='Next']").first().trigger("click");

next();
await refreshed();
console.log("after Next:   ", range());
customers.refresh(true);                                  // returns undefined: wait for the event
await refreshed();
console.log("refresh(true):", range());
customers.refresh();
await refreshed();
console.log("refresh():    ", range());
