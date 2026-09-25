// @page product-categories
const tree$ = apex.region("categories").widget();
tree$.on("treeviewactivatenode", (event, data) => console.log("activateNode:", data.nodes.map((n) => n.label)));
const node$ = tree$.find(".a-TreeView-content").eq(1);
tree$.treeView("setSelection", node$, true);
node$.trigger(apex.jQuery.Event("keydown", { which: 13, keyCode: 13, key: "Enter" }));   // the user presses Enter
tree$.treeView("focus");
console.log("focus on:", document.activeElement.textContent.trim());
