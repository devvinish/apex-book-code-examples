try {
    await apex.server.process("ORDER_SUMMARY", { x01: "999999" });
} catch (jqXHR) {                                         // the promise is rejected with the jqXHR
    console.log("rejected:", jqXHR.responseJSON);
}
apex.server.process("ORDER_SUMMARY", { x01: "999999" }, {
    success: (data) => console.log("success:", data),
    error: (jqXHR, textStatus, errorThrown) => console.log("error callback:", textStatus, "-", errorThrown)
});
await new Promise((resolve) => setTimeout(resolve, 1000));
