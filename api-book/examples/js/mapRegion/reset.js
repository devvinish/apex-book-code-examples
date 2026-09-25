// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
const zoom = () => map.getMapCenterAndZoomLevel().zoom.toFixed(2);
console.log("zoom:", zoom());
map.setZoomLevel(8);
await new Promise((resolve) => setTimeout(resolve, 1500));
console.log("zoom:", zoom());
map.reset();
await new Promise((resolve) => setTimeout(resolve, 3000));
console.log("after reset:", map.getMapObject() ? zoom() : "(map not ready)");
