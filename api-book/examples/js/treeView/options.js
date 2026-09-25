// @page product-categories
const tree$ = apex.region("categories").widget();       // the treeView of the Product Categories tree
const o = (name) => tree$.treeView("option", name);
console.log({ showRoot: o("showRoot"), expandRoot: o("expandRoot"), multiple: o("multiple"), navigation: o("navigation"),
              doubleClick: o("doubleClick"), dragAndDrop: o("dragAndDrop"), nodeSelector: o("nodeSelector"),
              iconType: o("iconType"), useLinks: o("useLinks"), autoCollapse: o("autoCollapse") });
const adapter = tree$.treeView("getNodeAdapter");
const root = adapter.root();
console.log("root:", adapter.getLabel(root), "- children:", adapter.childCount(root));
const camping = adapter.child(root, 0);
console.log("first:", adapter.getLabel(camping), camping.id, adapter.getIcon(camping), "- children:", adapter.childCount(camping));
