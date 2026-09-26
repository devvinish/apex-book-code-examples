apex.locale.resourcesLoaded(() => console.log("callback: resources loaded"));
const result = await apex.locale.resourcesLoaded();
console.log("promise resolved:", result);
