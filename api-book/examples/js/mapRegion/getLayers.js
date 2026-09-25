// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
for (const layer of map.getLayers()) {
    console.log(layer.name.padEnd(10), String(layer.id).padEnd(18), layer.style?.layerType || "point");
}
console.log("Stores:", map.getLayerIdByName("Stores"));
