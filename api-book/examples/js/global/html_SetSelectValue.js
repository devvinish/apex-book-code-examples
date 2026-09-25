// @page item-types
const first = apex.jQuery("#P20_DEPARTMENT option[value!='']").first().val();
html_SetSelectValue("P20_DEPARTMENT", first);
console.log("selected:", $v("P20_DEPARTMENT"));
html_SetSelectValue("P20_DEPARTMENT", "NO_SUCH_VALUE");
console.log("after an unknown value:", JSON.stringify($v("P20_DEPARTMENT")));
