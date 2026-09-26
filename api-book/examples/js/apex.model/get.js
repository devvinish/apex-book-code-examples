// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
const a = apex.model.get("orbitOrders");                  // reference count 2 (create + get)
const b = apex.model.get("orbitOrders");                  // 3
console.log("same model:", a === b);
apex.model.release("orbitOrders");
apex.model.release("orbitOrders");
console.log("after 2 releases:", apex.model.list(true).includes("orbitOrders"));
apex.model.destroy("orbitOrders");                        // regardless of the count
console.log("after destroy:", apex.model.list(true).includes("orbitOrders"), apex.model.get("orbitOrders") ?? null);
console.log("cached detail models:", apex.model.getMaxCachedModels());
