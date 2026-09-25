apex.message.confirm("Cancel order ORD-12283?", (okPressed) => console.log("okPressed:", okPressed),
                     { title: "Cancel Order", style: "danger", confirmLabel: "Cancel Order", cancelLabel: "Keep" });
await new Promise((resolve) => setTimeout(resolve, 600));
const buttons = apex.jQuery(".ui-dialog:visible .ui-dialog-buttonpane button");
console.log("buttons:", buttons.map((i, b) => b.textContent.trim()).get().join(", "));
buttons.last().trigger("click");                          // as if the user clicked "Cancel Order"
