// @page stores
// @before apex.model/_orders.js | creating the model of the `apex.model.create` example
console.log("region models:", apex.model.list());
console.log("with local models:", apex.model.list(true));
