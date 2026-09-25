// @page item-types
apex.jQuery("#text_items .t-Region-body").append('<img id="flag" src="/i/plus.gif">');
$x_SwitchImageSrc("flag", "plus", "/i/minus.gif");
console.log($x("flag").getAttribute("src"));
