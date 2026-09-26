// @page customer-overview
const customer = apex.item("P19_CUSTOMER_ID");
const original = customer.getValue();
console.log("changed:", apex.page.isChanged());
customer.setValue("12");
console.log("changed:", apex.page.isChanged());
customer.setValue(original);
console.log("changed:", apex.page.isChanged());
