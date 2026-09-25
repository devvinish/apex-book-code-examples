// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
const round = (n) => Math.round(n * 100) / 100;
const status = map.getMapStatus();
console.log("bbox:", status.bbox.map(round), "- zoom:", round(status.zoom));
console.log("pitch and bearing:", map.getMapPitchAndBearing());
console.log("same bbox:", JSON.stringify(map.getMapBboxAndZoomLevel().bbox) === JSON.stringify(status.bbox));
