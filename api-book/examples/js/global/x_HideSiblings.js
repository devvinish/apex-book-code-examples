// @page item-types
// in Universal Theme each item sits in its own grid column
const column = $x("P20_TEXT_CONTAINER").parentNode;
const hidden = $x_HideSiblings(column);
console.log(hidden.length, "sibling columns hidden:", hidden.map((col) => apex.jQuery(col).find(".apex-item-wrapper").attr("id")));
console.log("P20_TEXT visible:", apex.jQuery("#P20_TEXT").is(":visible"));
