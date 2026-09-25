// @shot .ui-dialog
apex.message.alert("The order has been cancelled.", () => console.log("alert closed"),
                   { title: "Order ORD-12283", style: "warning", okLabel: "Got it" });
await new Promise((resolve) => setTimeout(resolve, 600));
console.log("the code after alert runs at once: alert does not block");
