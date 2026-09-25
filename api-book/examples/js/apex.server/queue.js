// x02 makes the server wait that many seconds before it answers.
const call = (id, action) => apex.server.process("ORDER_SUMMARY", { x01: id, x02: "1" },
                                                 { queue: { name: "summary", action } })
    .then((data) => console.log(action, "answered:", data.orderNumber))
    .catch((e) => console.log(action, id, "->", e.statusText ?? e));
const start = Date.now();
await Promise.all([call("2282", "wait"), call("2280", "wait")]);
console.log("two waits:", Math.round((Date.now() - start) / 1000), "s (one after the other)");
await Promise.all([call("2282", "replace"), call("2280", "replace"), call("2279", "replace")]);
