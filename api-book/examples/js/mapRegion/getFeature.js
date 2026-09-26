// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
const feature = map.getFeature(map.getLayerIdByName("Stores"), "1");
console.log(feature.id, feature.geometry);
console.log(feature.columns);
