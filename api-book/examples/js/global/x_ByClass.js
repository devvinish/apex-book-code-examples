// @page item-types
const fields = $x_ByClass("text_field", "text_items", "INPUT");
console.log(fields.length, "text fields:", fields.map((f) => f.id));
