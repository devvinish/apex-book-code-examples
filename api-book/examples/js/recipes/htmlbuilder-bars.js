// @page stores
// @wait 600
// @shot #store_bars
// === Page › Execute when Page Loads ===
// Draws the five largest stores as bars under the grid, from the grid's own data.
function drawStoreBars() {
    const model = apex.region("stores").call("getViews", "grid").model;
    const stores = [];
    model.forEach((record) => stores.push({
        name: model.getValue(record, "STORE_NAME"),
        area: apex.locale.toNumber(model.getValue(record, "FLOOR_AREA_SQFT"))
    }));
    stores.sort((a, b) => b.area - a.area).splice(5);
    const out = apex.util.htmlBuilder();
    out.markup("<div").attr("id", "store_bars").attr("class", "u-padding-md").markup(">");
    for (const store of stores) {
        out.markup("<div").attr("class", "u-flex u-align-items-center u-margin-bottom-sm").markup(">")
           .markup("<span").css("width", "16rem").markup(">").content(store.name).markup("</span>")
           .markup("<span").css("width", `${Math.round(store.area / stores[0].area * 60)}%`)
           .css("height", "1rem").css("background-color", "var(--ut-palette-primary)")
           .markup("></span>")
           .markup("<span").attr("class", "u-margin-left-sm").markup(">")
           .content(apex.locale.formatNumber(store.area, "FM999G999") + " sq ft").markup("</span>")
           .markup("</div>");
    }
    out.markup("</div>");
    $("#store_bars").remove();
    out.toJquery().insertAfter("#stores");       // toJquery applies the css() values: no inline style
}
drawStoreBars();
// === Try it: the bars' widths, as the browser applied them ===
$("#store_bars > div").each((i, row) => console.log($(row).children().first().text(), "-",
    $(row).children().eq(1)[0].style.width));
