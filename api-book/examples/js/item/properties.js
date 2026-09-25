// @page item-types
const date = apex.item("P20_DATE");
console.log("id:", date.id);
console.log("item_type:", date.item_type);
console.log("node:", date.node.tagName, date.node.id);
console.log("element:", date.element.length, "element(s)");
