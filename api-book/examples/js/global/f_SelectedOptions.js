// @page item-types
apex.item("P20_DEPARTMENT").setValue(apex.jQuery("#P20_DEPARTMENT option[value!='']").eq(1).val());
const option = $f_SelectedOptions("P20_DEPARTMENT");
console.log("value:", option.value, "- text:", option.text);
