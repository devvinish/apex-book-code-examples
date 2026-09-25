const visible = () => apex.jQuery("#t_Alert_Success").is(":visible");
apex.message.setDismissPreferences({ dismissPageSuccess: true, dismissPageSuccessDuration: 1500 });
apex.message.showPageSuccess("Price list imported.");
console.log("shown:", visible());
await new Promise((resolve) => setTimeout(resolve, 2500));
console.log("after 2.5 s:", visible());
