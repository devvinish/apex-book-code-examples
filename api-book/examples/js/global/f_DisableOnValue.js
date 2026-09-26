// @page item-types
console.log("P20_RADIO =", $v("P20_RADIO"));
const matched = $f_DisableOnValue("P20_RADIO", "ONLINE", "P20_TEXT");
console.log("matched:", matched, "- P20_TEXT disabled:", apex.item("P20_TEXT").isDisabled());
