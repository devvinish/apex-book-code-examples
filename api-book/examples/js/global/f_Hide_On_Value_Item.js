// @page item-types
console.log("P20_SWITCH =", $v("P20_SWITCH"));
const matched = $f_Hide_On_Value_Item("P20_SWITCH", "P20_NUMBER", "Y");
console.log("matched:", matched, "- P20_NUMBER visible:", apex.jQuery("#P20_NUMBER").is(":visible"));
