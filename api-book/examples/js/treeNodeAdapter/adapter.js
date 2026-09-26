// @page product-categories
const adapter = apex.jQuery.apex.treeView.makeDefaultNodeAdapter({
    label: "Orbit", type: "root", id: "0", children: [
        { label: "Camping", type: "category", id: "1", link: "f?p=200:products", children: [] },
        { label: "Discontinued", type: "category", id: "9", isDisabled: true, classes: "is-muted", children: [] }] },
    { "default": { operations: { canAdd: false, canDelete: false, canRename: false, canDrag: false } },
      "category": { icon: "fa fa-folder-o", validChildren: true,
                    operations: { canAdd: true, canDelete: true, canRename: true, canDrag: true } } },
    true);
const root = adapter.root(), camping = adapter.child(root, 0), old = adapter.child(root, 1);
console.log("root: add", adapter.allowAdd(root, "add"), "- delete", adapter.allowDelete(root), "- rename", adapter.allowRename(root));
console.log("Camping: delete", adapter.allowDelete(camping), "- drag", adapter.allowDrag(camping), "- drag operations", adapter.dragOperations([camping]));
console.log("link:", adapter.getLink(camping), "- icon:", adapter.getIcon(camping));
console.log("Discontinued: disabled", adapter.isDisabled(old), "- classes", adapter.getClasses(old), "- hasChildren", adapter.hasChildren(old));
adapter.renameNode(camping, "Camping Gear", (node, index) => console.log("renamed:", adapter.getLabel(node), "at", index));
adapter.addNode(camping, 0, "Tents", null, (node, index) => console.log("added:", adapter.getLabel(node), "- id", node.id ?? "(none)"));
adapter.deleteNode(old, (ok) => console.log("deleted:", ok, "- children now", adapter.childCount(root)));
