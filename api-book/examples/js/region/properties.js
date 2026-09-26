// @page products
for (const region of Object.values(apex.regions)) {
    console.log(region.element.attr("id"), "- type:", region.type,
        "- widgetName:", region.widgetName, "- filterRegionId:", region.filterRegionId);
}
