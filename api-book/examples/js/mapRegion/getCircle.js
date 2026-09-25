// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
console.log("circle tool:", map.mapFeatures.circleTool);
console.log("getCircle:", map.getCircle());
map.clearCircle();                                        // nothing to clear: no error
console.log("cleared");
