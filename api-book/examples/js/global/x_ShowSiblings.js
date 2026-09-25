// @page item-types
const column = $x("P20_TEXT_CONTAINER").parentNode;
apex.jQuery(column).siblings().hide();
const shown = $x_ShowSiblings(column);
console.log(shown.length, "sibling columns shown");
