// @page stores
// @viewport 390,844
// @wait 600
// @shot #stores
// === Page › Execute when Page Loads ===
// On a narrow screen, the Stores grid shows only its most important columns.
const grid$ = apex.region("stores").call("getViews", "grid").view$;
const optional = ["STATE", "COUNTRY", "OPENED_ON"];
function fitColumns(narrow) {
    for (const column of optional) grid$.grid(narrow ? "hideColumn" : "showColumn", column);
}
const phone = window.matchMedia("(max-width: 640px)");
fitColumns(phone.matches);
phone.addEventListener("change", (event) => fitColumns(event.matches));   // rotating a tablet
// === Try it: open the page on a phone (390 pixels wide) ===
console.log("phone:", phone.matches, "- visible:", grid$.grid("getColumns")
    .filter((c) => !c.hidden && !c.property.startsWith("APEX$")).map((c) => c.property).join(" "));
