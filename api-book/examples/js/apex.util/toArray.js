console.log(apex.util.toArray("Red:Olive:Sand"));
console.log(apex.util.toArray("Red, Olive, Sand", /,\s*/));
console.log(apex.util.toArray('["Red","Olive"]', { type: "json-array" }));
console.log(apex.util.toArray(""), apex.util.toArray(null), apex.util.toArray(["a"]));
console.log(apex.util.toArray(document.querySelectorAll("header")).length);
