// @page item-types
apex.jQuery("#text_items .t-Region-body").append('<table><tr id="total_row"></tr></table>');
$tr_AddTD("total_row", "Total");
const cell = $tr_AddTD("total_row", "$1,329.95");
console.log(apex.jQuery("#total_row").html());
