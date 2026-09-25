// @page item-types
console.log("before:", $v("P20_TEXT"), "|", $v("P20_TEXTAREA"));
$f_Swap("P20_TEXT", "P20_TEXTAREA");
console.log("after: ", $v("P20_TEXT"), "|", $v("P20_TEXTAREA"));
