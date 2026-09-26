// @page item-types
console.log("department:", $f_SelectValue("P20_DEPARTMENT"));
apex.item("P20_DEPARTMENT").setValue(apex.jQuery("#P20_DEPARTMENT option[value!='']").first().val());
console.log("department:", $f_SelectValue("P20_DEPARTMENT"));
