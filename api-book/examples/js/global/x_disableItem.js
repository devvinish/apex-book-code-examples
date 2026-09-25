// @page item-types
$x_disableItem(["P20_TEXT", "P20_NUMBER"], true);
console.log(apex.item("P20_TEXT").isDisabled(), apex.item("P20_NUMBER").isDisabled());
