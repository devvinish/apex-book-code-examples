console.log(apex.util.arrayEqual([1, 2, 3], [1, 2, 3]));
console.log(apex.util.arrayEqual([1, 2, 3], [1, 2, "3"]));
console.log(apex.util.arrayEqual([{ a: 1 }], [{ a: 1 }]), "(shallow: two different objects)");
