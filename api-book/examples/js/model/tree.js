apex.model.create("orbitCategories", {
    shape: "tree", identityField: "id", childrenField: "children", parentIdentityField: "parentId",
    fields: { id: {}, name: {}, parentId: {}, children: {} }
}, { id: "0", name: "All Products", children: [
    { id: "1", name: "Camping", parentId: "0", children: [
        { id: "11", name: "Tents", parentId: "1", children: [] },
        { id: "12", name: "Sleeping Bags", parentId: "1", children: [] }] },
    { id: "2", name: "Clothing", parentId: "0", children: [
        { id: "21", name: "Jackets", parentId: "2", children: [] }] }] });
const tree = apex.model.get("orbitCategories");
const root = tree.root();
console.log("root:", tree.getValue(root, "name"), "- children:", tree.childCount(root), "- hasChildren:", tree.hasChildren(root));
const camping = tree.child(root, 0);
console.log("child 0:", tree.getValue(camping, "name"), "- parent:", tree.getValue(tree.parent(camping), "name"));
let depth = 0;
tree.walkTree(root, {
    node: (node) => console.log("  ".repeat(depth) + tree.getValue(node, "name")),
    beginChildren: () => { depth++; },
    endChildren: () => { depth--; }
});
