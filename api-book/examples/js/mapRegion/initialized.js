// @page store-map
// @beforeload
apex.jQuery(apex.gPageContext$).on("spatialmapinitialized", (event) => {
    const map = apex.region("store_map");
    console.log("spatialmapinitialized on", event.target.id);
    console.log("layers:", map.getLayers().map((layer) => layer.name).join(", "),
                "- zoom:", map.getMapCenterAndZoomLevel().zoom.toFixed(2));
});
