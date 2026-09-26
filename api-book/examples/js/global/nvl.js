// @page item-types
console.log($nvl(null, "(none)"));
console.log(JSON.stringify($nvl("", "(none)")));   // an empty string is kept
console.log($nvl($v("P20_TEXT"), "(none)"));
