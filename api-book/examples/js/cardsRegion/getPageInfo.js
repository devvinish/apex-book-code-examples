// @page product-catalog
const info = apex.region("catalog").getPageInfo();
console.log(info);
console.log(`cards ${info.firstOffset} to ${info.lastOffset} of ${info.total}, ${info.recordsPerRow} per row`);
