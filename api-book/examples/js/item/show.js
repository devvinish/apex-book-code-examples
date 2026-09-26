// @page item-types
const number = apex.item("P20_NUMBER");
number.hide();
number.show();
console.log("number visible:", apex.jQuery("#P20_NUMBER_CONTAINER").is(":visible"));
