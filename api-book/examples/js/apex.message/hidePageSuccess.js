const visible = () => apex.jQuery("#t_Alert_Success").is(":visible");
apex.message.showPageSuccess("Order ORD-12283 was shipped.");
console.log("shown:", visible());
apex.message.hidePageSuccess();
await new Promise((resolve) => setTimeout(resolve, 500));
console.log("after hidePageSuccess:", visible());
