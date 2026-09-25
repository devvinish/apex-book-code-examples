// @page item-types
apex.jQuery("#text_items .t-Region-body").append(
    '<img id="toggle_img" src="/i/plus.gif"><div id="details">Details</div>');
$x_ToggleWithImage("toggle_img", "details");
console.log($x("toggle_img").getAttribute("src"), "- details visible:", apex.jQuery("#details").is(":visible"));
