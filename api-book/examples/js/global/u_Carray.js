// @page item-types
console.log($u_Carray("P20_TEXT").map((n) => n));
const nodes = $u_Carray(["P20_TEXT", "P20_NUMBER"]);
console.log(nodes.length, "items:", nodes.join(", "));
console.log($u_Carray($x("P20_TEXT")).length, "element");
