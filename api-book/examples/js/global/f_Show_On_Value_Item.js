// @page item-types
apex.jQuery("#P20_NUMBER_CONTAINER").hide();
const matched = $f_Show_On_Value_Item("P20_RADIO", "P20_NUMBER", "ONLINE");
console.log("matched:", matched, "- P20_NUMBER visible:", apex.jQuery("#P20_NUMBER").is(":visible"));
