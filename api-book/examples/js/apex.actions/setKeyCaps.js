console.log("keycaps:", apex.actions.getKeyCaps());
console.log(apex.actions.shortcutDisplay("Ctrl+Shift+S"));
apex.actions.setKeyCaps({ Ctrl: "Strg", Shift: "Umschalt" });                 // a German keyboard
console.log(apex.actions.shortcutDisplay("Ctrl+Shift+S"));
apex.actions.setKeyCaps(null);
console.log("shortcutSupport:", apex.actions.shortcutSupport());
