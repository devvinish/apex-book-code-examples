// @page item-types
apex.jQuery("#text_items .t-Region-body").append('<table><tr id="head_row"></tr></table>');
$tr_AddTH("head_row", "Product");
$tr_AddTH("head_row", "Price");
console.log(apex.jQuery("#head_row").html());
