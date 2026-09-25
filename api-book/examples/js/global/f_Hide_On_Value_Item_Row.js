// @page item-types
const matched = $f_Hide_On_Value_Item_Row("P20_SWITCH", "P20_NUMBER", "Y");
console.log("matched:", matched);
console.log("P20_NUMBER visible:", apex.jQuery("#P20_NUMBER").is(":visible"),
    "- inside a table row:", apex.jQuery("#P20_NUMBER").closest("tr").length === 1);
