// @page home
// @wait 800
// @shot .ui-dialog:visible
// === Page › Execute when Page Loads (or on page 0, for every page) ===
const goTo = (page) =>
    apex.navigation.redirect(`f?p=${apex.env.APP_ID}:${page}:${apex.env.APP_SESSION}`);
apex.actions.add({ name: "go-orders", label: "Go to Orders", shortcut: "Alt+O",
                   action: () => goTo("orders") });
apex.actions.add({ name: "go-customers", label: "Go to Customers", shortcut: "Alt+C",
                   action: () => goTo("customers") });
apex.actions.add({
    name: "show-shortcuts",
    label: "Keyboard Shortcuts",
    shortcut: "Alt+/",
    action: () => {
        const lines = apex.actions.listShortcuts()
            .filter((s) => s.actionLabel)
            .map((s) => `${s.shortcutDisplay}   ${s.actionLabel}`);
        apex.message.alert(lines.join("\n"), null,
                           { title: "Keyboard Shortcuts", style: "information" });
    }
});
// === Try it: press Alt+/ ===
document.body.dispatchEvent(new KeyboardEvent("keydown",
    { key: "/", code: "Slash", keyCode: 191, altKey: true, bubbles: true, cancelable: true }));
await new Promise((resolve) => setTimeout(resolve, 500));
console.log($(".ui-dialog:visible .a-AlertMessage-details")[0].innerText);
