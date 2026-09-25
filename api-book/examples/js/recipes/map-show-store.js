// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
// @shot #store_map
// === Page › Function and Global Variable Declaration ===
// Flies the store map to a store and opens its info window.
function showStore(storeId) {
    const map = apex.region("store_map");
    const layerId = map.getLayerIdByName("Stores");
    const feature = map.getFeature(layerId, storeId);
    if (!feature) return;
    const [lng, lat] = feature.geometry.coordinates;
    map.getMapObject().flyTo({ center: [lng, lat], zoom: 12 });   // the MapLibre map
    map.getMapObject().once("moveend", () => map.displayPopup("infoWindow", layerId, storeId));
}
// === Try it: a link or a button calls showStore with the ID of the Chicago store ===
showStore("7");
await new Promise((resolve) => setTimeout(resolve, 4000));
const { center, zoom } = apex.region("store_map").getMapCenterAndZoomLevel();
console.log("center:", center.lng.toFixed(3), center.lat.toFixed(3), "- zoom:", zoom);
const popup = $("#store_map .maplibregl-popup-content")[0];
console.log("info window:", popup.innerText.trim().split("\n").filter(Boolean).join(" / "));
