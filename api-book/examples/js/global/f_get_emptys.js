// @page item-types
const empty = $f_get_emptys(["P20_TEXT", "P20_PASSWORD", "P20_NUMBER"], "is-empty", "is-filled");
console.log("empty items:", empty && empty.map((node) => node.id));
console.log("classes:", $x("P20_PASSWORD").className, "|", $x("P20_TEXT").className);
