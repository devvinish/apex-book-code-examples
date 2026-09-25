// @page stores
// What an Initialization JavaScript Function does with the toolbar, run here on a copy:
const toolbarData = apex.jQuery.apex.interactiveGrid.copyDefaultToolbar();
console.log("groups:", toolbarData.map((group) => group.id).join(" "));
toolbarData.toolbarRemove("reset-report");                 // remove the Reset button
toolbarData.toolbarFind("actions3").controls.push({
    type: "BUTTON", action: "orbit-export-stores", label: "Export", icon: "icon-ig-download", iconBeforeLabel: true
});
console.log("actions3:", toolbarData.toolbarFind("actions3").controls.map((c) => c.action));
console.log("reset-report:", toolbarData.toolbarFind("reset-report"));
