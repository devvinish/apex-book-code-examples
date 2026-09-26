// @page orders
// @onload
// @wait 1000
// === Page › Execute when Page Loads ===
// Keeps a draft of the order's notes in the browser tab until the order is saved.
const drafts = apex.storage.getScopedSessionStorage({ prefix: "notes-draft", usePageId: true });
const key = apex.item("P10_ORDER_ID").getValue();
const draft = drafts.getItem(key);
if (draft !== null && draft !== apex.item("P10_NOTES").getValue()) {
    apex.item("P10_NOTES").setValue(draft);
    apex.message.showPageSuccess("Your unsaved notes were restored.");
}
$("#P10_NOTES").on("input", apex.util.debounce(() =>
    drafts.setItem(key, apex.item("P10_NOTES").getValue()), 500));
apex.gPageContext$.on("apexbeforepagesubmit", () => drafts.removeItem(key));
// --- after the page loads ---
// === Try it: open an order, type notes, and reload the page by mistake ===
$("#orders a[href*='order']").first()[0].click();
// --- on the Order page ---
$("#P10_NOTES").val("Deliver to the loading dock.").trigger("input");
await new Promise((resolve) => setTimeout(resolve, 800));
location.reload();
// --- on the reloaded page ---
await new Promise((resolve) => setTimeout(resolve, 500));
console.log("notes:", apex.item("P10_NOTES").getValue());
console.log("message:", $("#APEX_SUCCESS_MESSAGE .t-Alert-title").text().trim());
