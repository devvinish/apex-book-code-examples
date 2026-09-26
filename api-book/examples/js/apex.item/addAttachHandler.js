// @page item-types
// @beforeload
apex.item.addAttachHandler(function (context$) {
    const count = context$.find(".apex-item-text").length;
    console.log("attach handler called with", context$.length, "context;", count, "text items in it");
});
