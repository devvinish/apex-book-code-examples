// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
const stores = map.getLayerIdByName("Stores");
map.addFeature(stores, { id: "901", geometry: { type: "Point", coordinates: [-149.90, 61.22] } });
console.log("before refresh:", Object.keys(map.getFeature(stores, "901")).length > 0);
await map.refresh();                                      // fetches the layers again
console.log("after refresh: ", Object.keys(map.getFeature(stores, "901")).length > 0);
