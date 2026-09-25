// @page item-types
const department = apex.item("P20_DEPARTMENT");
const first = department.element.find("option[value!='']").first().val();
console.log(first, "is", department.displayValueFor(first));

const shuttle = apex.item("P20_SHUTTLE");
const values = shuttle.element.find("option").slice(0, 2).map((i, o) => o.value).get();
console.log(values, "are", shuttle.displayValueFor(values));

// Select Many loads its options when the user opens it: until then it has no display values
console.log(apex.item("P20_SELECT_MANY").displayValueFor(["1", "3"]));
