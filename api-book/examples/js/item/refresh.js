// @page item-types
// @wait 1500
const category = apex.item("P20_CATEGORY");
category.element.on("apexafterrefresh", () =>
    console.log("categories after refresh:", category.element.find("option").length));
apex.jQuery("#P20_DEPARTMENT").val(apex.jQuery("#P20_DEPARTMENT option[value!='']").eq(1).val());
category.refresh();
