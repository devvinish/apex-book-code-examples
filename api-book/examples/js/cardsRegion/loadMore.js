// @page product-catalog
const catalog = apex.region("catalog");
const pause = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
const cards = () => catalog.element.find(".a-CardView-item").length + " cards in the DOM";
console.log(cards());
console.log("loadMore:", catalog.loadMore());
await pause(1500);
console.log(cards());
console.log("lastPage:", catalog.lastPage());
await pause(2000);
console.log(cards(), "- last offset", catalog.getPageInfo().lastOffset);
