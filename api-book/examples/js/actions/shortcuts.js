apex.actions.add({ name: "orbit-new-order", label: "New Order", shortcut: "Alt+N",
                   action: () => { console.log("action: new order"); return true; } });
apex.actions.addShortcut("Ctrl+Alt+O", "orbit-new-order");
console.log(apex.actions.listShortcuts().filter((s) => s.actionName === "orbit-new-order"));
console.log("display:", apex.actions.shortcutDisplay("Ctrl+Alt+O"), "- aria:", apex.actions.ariaKeyshortcut("Ctrl+Alt+O"));
const press = (key, mods) => document.body.dispatchEvent(new KeyboardEvent("keydown", { key, code: "Key" + key.toUpperCase(), keyCode: key.toUpperCase().charCodeAt(0), bubbles: true, ...mods }));
press("n", { altKey: true });                              // the user presses Alt+N
apex.actions.disableShortcuts();
press("n", { altKey: true });                              // ignored
apex.actions.enableShortcuts();
console.log("removeShortcut:", apex.actions.removeShortcut("Ctrl+Alt+O"));
