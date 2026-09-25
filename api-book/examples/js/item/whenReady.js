// @page item-types
const editor = apex.item("P20_RICH_TEXT");
await editor.whenReady();                        // the editor library has loaded
editor.setValue("<p>Ships in <strong>2 days</strong>.</p>");
console.log(editor.getValue());
