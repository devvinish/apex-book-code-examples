// @page customers
// the region that contains a cell of the report
const cell = apex.jQuery("#customers td").first();
const region = apex.region.findClosest(cell);
console.log(region.type, region.element.attr("id"));
console.log(apex.region.findClosest("#t_Header"));   // not inside a region
