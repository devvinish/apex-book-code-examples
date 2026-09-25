// @page product-categories
// A tree of your own: the default node adapter over a simple node structure.
const adapter = apex.jQuery.apex.treeView.makeDefaultNodeAdapter({
    label: "Orbit", type: "root", id: "0", children: [
        { label: "Camping", type: "category", id: "1", children: [
            { label: "Tents", type: "category", id: "11", children: [] },
            { label: "Sleeping Bags", type: "category", id: "12", children: [] }] },
        { label: "Clothing", type: "category", id: "2", children: [
            { label: "Jackets", type: "category", id: "21", children: [] }] }] },
    {                                                        // node types
        "default": { operations: { canAdd: false, canDelete: false, canRename: false, canDrag: false } },
        "root": { icon: "fa fa-home" },
        "category": { icon: "fa fa-folder-o", validChildren: ["category"],
                      operations: { canAdd: true, canDelete: true, canRename: true, canDrag: true } }
    },
    true);                                                   // the nodes have IDs
apex.jQuery(`<div id="orbit_tree"></div>`).insertBefore("#categories").treeView({
    getNodeAdapter: () => adapter, showRoot: true, expandRoot: true, multiple: true
});
const tree$ = apex.jQuery("#orbit_tree");
tree$.treeView("expandAll");
const find = (label) => {                                  // the tree node of the node with a label
    const walk = (n) => adapter.getLabel(n) === label ? n
        : Array.from({ length: adapter.childCount(n) ?? 0 }, (_, i) => walk(adapter.child(n, i))).find(Boolean);
    return tree$.treeView("getTreeNode", walk(adapter.root()));
};
const show = () => { const out = []; const walk = (n, depth) => { out.push("  ".repeat(depth) + adapter.getLabel(n));
    for (let i = 0; i < (adapter.childCount(n) ?? 0); i++) walk(adapter.child(n, i), depth + 1); }; walk(adapter.root(), 0); return out.join("\n"); };
tree$.treeView("addNode", find("Camping"), 0, { label: "Camp Kitchen", type: "category", id: "13", children: [] });
tree$.treeView("moveNodes", find("Clothing"), 0, find("Sleeping Bags"));
tree$.treeView("deleteNodes", find("Jackets"));
const tents$ = find("Tents");
tree$.treeView("getNodes", tents$)[0].label = "Tents & Shelters";   // changed in the data...
tree$.treeView("update", tents$);                                    // ...and shown
await new Promise((resolve) => setTimeout(resolve, 300));
console.log(show());
