// @page customer-overview
let editorDirty = false;                                  // state outside APEX items and models
apex.page.warnOnUnsavedChanges("You have unsaved changes.", () => editorDirty);
console.log("changed:", apex.page.isChanged());
editorDirty = true;
console.log("changed:", apex.page.isChanged());
apex.page.cancelWarnOnUnsavedChanges();
editorDirty = false;
console.log("after cancelWarnOnUnsavedChanges:", apex.page.isChanged());
