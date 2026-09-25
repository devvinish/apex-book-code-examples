// @page product-catalog
const catalog = apex.region("catalog");
catalog.element.find(".a-CardView-title").first().text("Changed in the DOM");
console.log(catalog.element.find(".a-CardView-title").first().text());
catalog.refreshView();                                    // redraw from the model, no server call
console.log(catalog.element.find(".a-CardView-title").first().text());
