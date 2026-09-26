// @page product-categories
// @shot #categories .t-Region-body
// @wait 600
// === Page › Function and Global Variable Declaration ===
// Shows the categories whose names contain the text: collapses the tree, expands the path to
// each match, and selects the first match.
function searchTree(text) {
    const tree$ = apex.region("categories").widget();
    tree$.treeView("expandAll");                                  // so that find sees every node
    const matches$ = text ? tree$.treeView("find", {
        depth: -1, findAll: true,
        match: (node) => node.label.toLowerCase().includes(text.toLowerCase())
    }) : $();
    tree$.treeView("collapseAll");
    matches$.each((i, content) => {
        // expand every ancestor, from the top down
        $(content).parents(".a-TreeView-node").get().reverse().slice(0, -1).forEach((node) =>
            tree$.treeView("expand", $(node).children(".a-TreeView-content")));
    });
    tree$.treeView("setSelection", matches$.first(), true);      // and focus it
    return tree$.treeView("getNodes", matches$).map((node) => node.label);
}
// === Try it: search for "bag" ===
console.log("found:", searchTree("bag"));
const expanded = apex.region("categories").widget().treeView("getExpandedNodeIds");
console.log("expanded:", expanded.length, "nodes");
