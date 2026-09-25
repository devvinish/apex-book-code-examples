// @page item-types
$f_CheckAll("P20_CHECKBOX_GROUP", true);
console.log("checked:", apex.item("P20_CHECKBOX_GROUP").getValue());
$f_CheckAll("P20_CHECKBOX_GROUP", false);
console.log("after unchecking:", apex.item("P20_CHECKBOX_GROUP").getValue());
