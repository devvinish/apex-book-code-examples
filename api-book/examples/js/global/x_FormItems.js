// @page item-types
const checkboxes = $x_FormItems("choice_items", "checkbox");
console.log(checkboxes.length, "checkboxes:", checkboxes.map((c) => c.id).slice(0, 4));
