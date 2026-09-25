// @page item-types
// @wait 1500
const category = apex.item("P20_CATEGORY");
category.element
    .on("apexbeforerefresh", () =>
        console.log("before refresh:", category.element.find("option").length, "options"))
    .on("apexafterrefresh", () =>
        console.log("after refresh:", category.element.find("option").length, "options"));

// choosing a department refreshes the categories that depend on it
const department = apex.item("P20_DEPARTMENT");
department.setValue(department.element.find("option[value!='']").first().val());
