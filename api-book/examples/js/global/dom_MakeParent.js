// @page item-types
const note = $dom_AddTag("text_items", "p", "Moved note");
$dom_MakeParent(note, "choice_items");
console.log("now inside:", note.parentNode.id);
