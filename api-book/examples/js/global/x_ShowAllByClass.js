// @page item-types
apex.jQuery("#text_items .t-Region-body").append(
    '<div id="tips"><p class="tip">Tip 1</p><p class="tip">Tip 2</p></div>');
apex.jQuery("#tips .tip").hide();
console.log("visible tips:", apex.jQuery("#tips .tip:visible").length);
$x_ShowAllByClass("tips", "tip", "P");
console.log("visible tips:", apex.jQuery("#tips .tip:visible").length);
