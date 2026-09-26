// @page item-types
const column = $x("P20_TEXT_CONTAINER").parentNode;
const siblings = $x_SetSiblingsClass(column, "is-dimmed", "is-active");
console.log(siblings.length, "siblings now have:", siblings[0].className);
console.log("the column itself:", column.className);
