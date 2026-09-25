// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
const mapLibre = map.getMapObject();
const visible = (id) => mapLibre.getLayoutProperty(String(id), "visibility") ?? "visible";
const customers = map.getLayerIdByName("Customers");
map.hideLayer("Customers");
console.log("Customers:", visible(customers));
map.showLayer(customers);
console.log("Customers:", visible(customers));
