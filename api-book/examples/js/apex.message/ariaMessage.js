apex.message.ariaMessage("12 orders loaded.");
apex.message.ariaAlertMessage("Connection lost. Changes are not saved.");
await new Promise((resolve) => setTimeout(resolve, 100));
// Each message goes into a visually hidden element that is removed after 5 seconds:
apex.jQuery("body > .u-vh[role]").each((i, e) =>
    console.log(`role=${e.getAttribute("role")} id=${e.id}: ${e.textContent}`));
await new Promise((resolve) => setTimeout(resolve, 5100));
console.log("after 5 s:", apex.jQuery("body > .u-vh[role]").length, "elements");
