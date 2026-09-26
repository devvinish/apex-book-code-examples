// @page item-types
apex.jQuery("#text_items .t-Region-body").append(
    '<table><tr id="row_1"><td>Tents</td><td>12</td></tr></table>');
$x_RowHighlight("row_1", "#fff3cd");
$x_RowHighlightOff("row_1");
console.log(apex.jQuery("#row_1 td").map((i, td) => JSON.stringify(td.style.backgroundColor)).get());
