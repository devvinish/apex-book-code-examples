// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
console.log("tileLayer:", map.tileLayer.type, map.tileLayer.name, "- vector tiles:", map.useVectorTileLayers);
console.log("navigationBar:", map.navigationBar);
console.log("mapFeatures:", map.mapFeatures);
console.log("layers:", map.layers.map((layer) => layer.label).join(", "));
