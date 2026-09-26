const panel = apex.jQuery(`<div id="orbit_panel" tabindex="-1"><button type="button" data-action="save-note">Save</button></div>`)
    .appendTo("#recent_orders .t-Region-body")[0];
const panelActions = apex.actions.createContext("orbitPanel", panel);
panelActions.add({ name: "save-note", label: "Save Note", action: () => console.log("saved in the panel context") });
console.log("typeName:", panelActions.typeName, "- context:", panelActions.context.id);
console.log("types:", apex.actions.getContextTypes());
console.log("findContext:", apex.actions.findContext("orbitPanel", panel) === panelActions,
            "- findContextById:", apex.actions.findContextById("orbit_panel") === panelActions);
console.log("contexts of type:", apex.actions.getContextsForType("orbitPanel").length);
panelActions.invoke("save-note");
console.log("in the global context:", apex.actions.lookup("save-note") ?? "(not there)");
panelActions.clear();
apex.actions.removeContext("orbitPanel", panel);
console.log("after removeContext:", apex.actions.getContextTypes());
