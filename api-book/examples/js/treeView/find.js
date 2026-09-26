// @page product-categories
const tree$ = apex.region("categories").widget();       // the treeView of the Product Categories tree
tree$.treeView("expandAll");
const found$ = tree$.treeView("find", { depth: -1, match: (node) => /^(Tents|Sleeping Bags)$/.test(node.label), findAll: true });
console.log("found:", tree$.treeView("getNodes", found$).map((n) => n.label));
tree$.on("treeviewselectionchange", () => console.log("selectionChange:", tree$.treeView("getSelectedNodes").map((n) => n.label)));
tree$.treeView("setSelection", found$.first(), true);
await new Promise((resolve) => setTimeout(resolve, 200));  // the event follows a moment later
console.log("selection:", tree$.treeView("getSelection").text());
const adapter = tree$.treeView("getNodeAdapter");
tree$.treeView("setSelectedNodes", [adapter.child(adapter.root(), 1)], false, true);   // no event
await new Promise((resolve) => setTimeout(resolve, 200));
console.log("selected:", tree$.treeView("getSelectedNodes").map((n) => n.label));
