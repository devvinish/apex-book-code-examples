// @page product-categories
// @onload
// @wait 800
// === Page › Execute when Page Loads ===
// The tree opens with the nodes expanded that the user had expanded on the last visit.
const tree$ = apex.region("categories").widget();
const prefs = apex.storage.getScopedLocalStorage({ prefix: "categories", usePageId: true });
const saved = JSON.parse(prefs.getItem("expanded") || "null");
const byId = (id) => tree$.treeView("find", { depth: -1, match: (node) => node.id === id });
if (saved) {
    tree$.treeView("expandAll");                               // render every node, then
    tree$.treeView("collapseAll");                             // start from a collapsed tree
    for (const id of saved) {                                  // parents come before children
        tree$.treeView("expand", byId(id));
    }
}
tree$.on("treeviewexpansionstatechange", () =>
    prefs.setItem("expanded", JSON.stringify(tree$.treeView("getExpandedNodeIds"))));
// --- after the page loads ---
// === Try it: expand Hiking and Backpacks, then come back to the page ===
const tree$ = apex.region("categories").widget();
const find = (match) => tree$.treeView("find", { depth: -1, match });
const expandedLabels = () => tree$.treeView("getExpandedNodeIds")
    .map((id) => tree$.treeView("getNodes", find((node) => node.id === id))[0].label).join(", ");
tree$.treeView("collapseAll");
for (const label of ["Hiking", "Backpacks"]) {
    tree$.treeView("expand", find((node) => node.label === label));
}
console.log("before:", expandedLabels());
location.reload();
// --- on the next page ---
const tree = apex.region("categories").widget();
console.log("after: ", tree.treeView("getExpandedNodeIds").map((id) => tree.treeView("getNodes",
    tree.treeView("find", { depth: -1, match: (node) => node.id === id }))[0].label).join(", "));
