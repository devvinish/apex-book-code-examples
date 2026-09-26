// @page orders
// @wait 800
// === Try it: open an order from the Orders page ===
$("#orders a[href*='order']").first()[0].click();
// --- on the Order page ---
// === Page › Execute when Page Loads ===
apex.actions.add({
    name: "save-order",
    label: "Save Order",
    shortcut: "CtrlOrMeta+S",                         // Command+S on macOS, Ctrl+S elsewhere
    action: () => apex.page.submit("SAVE")            // what the Apply Changes button does
});
// show the shortcut on the button, the way the user's keyboard writes it
$("#save_order").attr("title", "Apply Changes (" + apex.actions.shortcutDisplay("CtrlOrMeta+S") + ")");
// === Try it: type in Notes and press the shortcut (the submit is stopped here) ===
apex.gPageContext$.on("apexbeforepagesubmit", (event, request) => {
    console.log("submit with request", request);
    apex.event.gCancelFlag = true;
});
const notes = document.getElementById("P10_NOTES");
notes.focus();
const mac = /Mac/.test(navigator.platform);
const key = new KeyboardEvent("keydown", { key: "s", code: "KeyS", keyCode: 83,
    metaKey: mac, ctrlKey: !mac, bubbles: true, cancelable: true });
notes.dispatchEvent(key);
console.log("button title:", $("#save_order").attr("title"), "- browser's own Save:",
            key.defaultPrevented ? "prevented" : "not prevented");
