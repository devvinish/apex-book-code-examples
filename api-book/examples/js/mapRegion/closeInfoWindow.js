// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
const stores = map.getLayerIdByName("Stores");
const popups = () => map.element.find(".maplibregl-popup").length;
map.displayPopup("infoWindow", stores, "1", false);
map.displayPopup("infoWindow", stores, "2", false);
console.log("open:", popups());
map.closeInfoWindow(stores, "1");
console.log("after closeInfoWindow:", popups());
map.closeAllInfoWindows();
console.log("after closeAllInfoWindows:", popups());
map.displayPopup("tooltip", stores, "3", false);
console.log("tooltip:", map.element.find(".maplibregl-popup").text().trim());
map.closeTooltip();
console.log("after closeTooltip:", popups());
