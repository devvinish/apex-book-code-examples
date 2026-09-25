// @page stores
const gridActions = apex.actions.findContextById("stores");      // the interactive grid's context
console.log("typeName:", gridActions.typeName, "- actions:", gridActions.list().length);
console.log(gridActions.list().filter((a) => /save|refresh|selection-add|edit/.test(a.name)).slice(0, 6));
console.log("edit mode:", gridActions.get("edit"));
gridActions.set("edit", true);
console.log("edit mode:", gridActions.get("edit"));
