// In a dynamic action plug-in, this.resumeCallback continues with the next action.
const resumeCallback = (errorOccurred) => console.log("resume, errorOccurred:", errorOccurred);
apex.server.process("ORDER_SUMMARY", { x01: "2282" }).then((data) => {
    console.log("got", data.orderNumber);
    apex.da.resume(resumeCallback, false);
});
await new Promise((resolve) => setTimeout(resolve, 1500));
