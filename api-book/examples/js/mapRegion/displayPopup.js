// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
// @shot #store_map
const map = apex.region("store_map");
const stores = map.getLayerIdByName("Stores");
map.setCenter([-105.0003, 39.7527]);
map.setZoomLevel(11);
await new Promise((resolve) => setTimeout(resolve, 2000));
map.displayPopup("infoWindow", stores, "1", false);
await new Promise((resolve) => setTimeout(resolve, 1000));
console.log("open:", map.element.find(".maplibregl-popup").length, "popup");
