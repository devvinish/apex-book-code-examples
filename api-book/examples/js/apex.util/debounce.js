const search = apex.util.debounce((text) => console.log("search for:", text), 300);
for (const text of ["t", "te", "ten", "tent"]) search(text);        // the user types quickly
await new Promise((resolve) => setTimeout(resolve, 500));
const saveNow = apex.util.debounce(() => console.log("immediate call"), 300, true);
saveNow(); saveNow(); saveNow();
await new Promise((resolve) => setTimeout(resolve, 400));
