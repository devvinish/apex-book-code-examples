// @page item-types
// === Page › Function and Global Variable Declaration ===
// Sets cascading lists in order: [[parent, value], [child, value], ...]
async function setCascading(values) {
    for (let i = 0; i < values.length; i++) {
        const [name, value] = values[i];
        const child = values[i + 1];
        // the child list reloads when its parent changes: wait for that before setting it
        const reloaded = child
            ? new Promise((resolve) => $("#" + child[0]).one("apexafterrefresh", resolve))
            : null;
        apex.item(name).setValue(value);
        await reloaded;
    }
}
// === Try it: choose a product in all three lists at once ===
await setCascading([["P20_DEPARTMENT", "1"], ["P20_CATEGORY", "9"], ["P20_PRODUCT", "16"]]);
for (const name of ["P20_DEPARTMENT", "P20_CATEGORY", "P20_PRODUCT"]) {
    const value = apex.item(name).getValue();
    console.log(name, value, apex.item(name).displayValueFor(value));
}
