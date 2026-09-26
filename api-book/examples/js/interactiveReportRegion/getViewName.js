// @page customers
const customers = apex.region("customers");
console.log("view:", customers.getViewName());
console.log("selection:", customers.getSelectedValues(), "- current row:", customers.getCurrentRowValue());
