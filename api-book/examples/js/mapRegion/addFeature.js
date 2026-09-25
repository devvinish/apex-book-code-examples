// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
const stores = map.getLayerIdByName("Stores");
map.on("spatialmapchanged", (event, data) => console.log("changed:", data.changeType));
map.addFeature(stores, {
    id: "901",
    geometry: { type: "Point", coordinates: [-149.9003, 61.2181] },
    tooltip: "Orbit Anchorage (planned)"
});
console.log("added:", map.getFeature(stores, "901").tooltip);
map.updateFeature(stores, { id: "901", geometry: { type: "Point", coordinates: [-149.9003, 61.2181] },
                            tooltip: "Orbit Anchorage Midtown" });
console.log("updated:", map.getFeature(stores, "901").tooltip);
map.removeFeature(stores, "901");
console.log("removed:", map.getFeature(stores, "901"));
