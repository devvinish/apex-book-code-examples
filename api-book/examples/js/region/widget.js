// @page product-categories
const tree$ = apex.region("categories").widget();
console.log("widget element:", tree$.attr("id"), "- is a treeView:", tree$.hasClass("a-TreeView"));
console.log("top-level nodes:", tree$.treeView("getNodes", tree$.find(".a-TreeView-node--topLevel").first()).length);
