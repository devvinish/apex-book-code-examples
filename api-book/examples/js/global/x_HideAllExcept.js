// @page item-types
const all = ["P20_TEXT_CONTAINER", "P20_NUMBER_CONTAINER", "P20_DATE_CONTAINER"];
$x_HideAllExcept("P20_NUMBER_CONTAINER", all);
console.log(all.map((id) => id + ": " + apex.jQuery("#" + id).is(":visible")));
