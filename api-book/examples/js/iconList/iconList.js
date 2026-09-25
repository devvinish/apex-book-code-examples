// @shot #orbit_icons
if (!apex.jQuery.fn.iconList) {                           // not every page loads the widget
    await new Promise((resolve) => apex.server.loadScript({ path: apex.env.APEX_FILES + "libraries/apex/minified/widget.iconList.min.js" }, resolve));
}
apex.jQuery(`<ul id="orbit_icons">
  <li data-value="tent"><span class="fa fa-home"></span> Tents</li>
  <li data-value="bag"><span class="fa fa-bed"></span> Sleeping Bags</li>
  <li data-value="jacket"><span class="fa fa-user"></span> Jackets</li>
  <li data-value="boot"><span class="fa fa-male"></span> Footwear</li>
</ul>`).insertBefore("#recent_orders").iconList({ multiple: true, itemSelector: true, addItemSelector: true });
const list$ = apex.jQuery("#orbit_icons");
list$.on("iconlistselectionchange", () => console.log("selectionchange:", list$.iconList("getSelectionValues")));
list$.on("iconlistactivate", (event, data) => console.log("activate:", data.values));
list$.iconList("setSelection", list$.children().slice(1, 3), true);
await new Promise((resolve) => setTimeout(resolve, 200));
console.log("selection:", list$.iconList("getSelection").map((i, li) => li.textContent.trim()).get());
console.log("columns:", list$.iconList("getColumns"), "- rows:", list$.iconList("getRows"));
list$.iconList("getSelection").first().trigger(apex.jQuery.Event("keydown", { which: 13, keyCode: 13, key: "Enter" }));
await new Promise((resolve) => setTimeout(resolve, 200));
