// @page item-types
const a = apex.item("P20_TEXT"), b = apex.item("P20_TEXTAREA");
const aValue = a.getValue();
a.setValue(b.getValue());
b.setValue(aValue);
console.log("after: ", $v("P20_TEXT"), "|", $v("P20_TEXTAREA"));
