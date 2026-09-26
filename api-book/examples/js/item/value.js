// @page item-types
const text = apex.item("P20_TEXT");
console.log(text.value);
text.value = "Glacier Trekking Poles";   // the same as setValue
console.log($v("P20_TEXT"));
