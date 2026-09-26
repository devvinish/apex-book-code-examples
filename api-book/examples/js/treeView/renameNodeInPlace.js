// @page product-categories
const adapter = apex.jQuery.apex.treeView.makeDefaultNodeAdapter(
    { label: "Orbit", id: "0", children: [{ label: "Camping", id: "1", children: [] }] },
    { "default": { operations: { canAdd: true, canRename: true, canDelete: true } } }, true);
apex.jQuery(`<div id="orbit_tree"></div>`).insertBefore("#categories").treeView({ getNodeAdapter: () => adapter, showRoot: true });
const tree$ = apex.jQuery("#orbit_tree");
tree$.on("treeviewbeginedit treeviewendedit", (event, data) => console.log(event.type, data.action));
const camping$ = tree$.treeView("getTreeNode", adapter.child(adapter.root(), 0));
tree$.treeView("renameNodeInPlace", camping$);            // an input replaces the label
const input = tree$.find("input");
input.val("Camping & Hiking").trigger(apex.jQuery.Event("keydown", { which: 13, keyCode: 13, key: "Enter" }));
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("label:", adapter.getLabel(adapter.child(adapter.root(), 0)));
tree$.treeView("addNodeInPlace", tree$.treeView("getTreeNode", adapter.root()), "New Category");
tree$.find("input").trigger(apex.jQuery.Event("keydown", { which: 13, keyCode: 13, key: "Enter" }));
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("children:", adapter.childCount(adapter.root()), "-", adapter.getLabel(adapter.child(adapter.root(), 1)));
