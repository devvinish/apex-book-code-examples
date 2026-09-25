// @page store-map
// @waitfor apex.region("store_map").mapData && apex.region("store_map").getMapObject()?.loaded()
// @setup new Promise((resolve) => setTimeout(resolve, 2500))
const map = apex.region("store_map");
const order = () => map.getMapObject().getStyle().layers.slice(-2)
    .map((layer) => map.getLayers().find((l) => String(l.id) === layer.id).name).join(" below ");
console.log(order());
map.moveLayer(map.getLayerIdByName("Stores"), map.getLayerIdByName("Customers"));
console.log(order());
