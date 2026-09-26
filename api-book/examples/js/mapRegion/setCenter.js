// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
map.on("spatialmapchanged", (event, data) => console.log("changed:", data.changeType, "- zoom", data.zoom.toFixed(2)));
map.setCenter([-104.99, 39.74]);                          // longitude, latitude: Denver
map.setZoomLevel(10);
await new Promise((resolve) => setTimeout(resolve, 2500));
const { center, zoom } = map.getMapCenterAndZoomLevel();
console.log("center:", center.lng.toFixed(2), center.lat.toFixed(2), "- zoom:", zoom);
