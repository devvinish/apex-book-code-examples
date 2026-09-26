// @page item-types
$s("P20_TEXT", "Summit Down Sleeping Bag");
console.log($v("P20_TEXT"));

// a popup LOV with a display value, without triggering a change event
$s("P20_POPUP_LOV", "7", "Rocky Mountain Outfitters", true);
console.log($v("P20_POPUP_LOV"), "-", apex.jQuery("#P20_POPUP_LOV").val());
