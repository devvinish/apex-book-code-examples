// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
const mapLibre = map.getMapObject();
map.on("spatialmapclick", (event, data) => console.log("spatialmapclick:", data.lng.toFixed(2), data.lat.toFixed(2)));
map.on("spatialmapobjectclick", (event, data) => console.log("spatialmapobjectclick:", data.id, data.tooltip));
// what a click on the map does, done with MapLibre (for the example only)
const lngLat = { lng: -90, lat: 10 };
mapLibre.fire("click", { lngLat, point: mapLibre.project(lngLat), originalEvent: {} });
