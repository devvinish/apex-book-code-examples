// @page item-types
const matched = $f_Show_On_Value_Item_Row("P20_RADIO", "P20_NUMBER", "ONLINE");
console.log("matched:", matched, "- rows found:", apex.jQuery("#P20_NUMBER").closest("tr").length);
