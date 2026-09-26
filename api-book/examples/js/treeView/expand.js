// @page product-categories
const tree$ = apex.region("categories").widget();       // the treeView of the Product Categories tree
const log = (event, data) => console.log("expansionStateChange:", data.node.label, data.expanded ? "expanded" : "collapsed");
tree$.on("treeviewexpansionstatechange", log);
const camping$ = tree$.treeView("getTreeNode", tree$.treeView("getNodeAdapter").child(tree$.treeView("getNodeAdapter").root(), 0));
tree$.treeView("expand", camping$);
console.log("expanded:", tree$.treeView("getExpandedNodeIds"));
tree$.off("treeviewexpansionstatechange", log);
tree$.treeView("expandAll");
console.log("after expandAll:", tree$.treeView("getExpandedNodeIds").length, "nodes");
tree$.treeView("collapseAll");
tree$.treeView("expand");                                  // the root
const state = tree$.treeView("getExpandedState");
console.log("state:", Object.keys(state).length, "nodes,", Object.values(state).filter(Boolean).length, "expanded");
