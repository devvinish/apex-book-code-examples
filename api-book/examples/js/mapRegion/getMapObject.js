// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const mapLibre = apex.region("store_map").getMapObject();
console.log("MapLibre", maplibregl.getVersion ? maplibregl.getVersion() : maplibregl.version);
console.log("style layers:", mapLibre.getStyle().layers.length, "- zoom:", mapLibre.getZoom().toFixed(2));
mapLibre.setPitch(45);                                    // tilt: no region method for this
console.log("pitch:", apex.region("store_map").getMapPitchAndBearing().pitch);
