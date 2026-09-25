// @page item-types
apex.jQuery("#text_items .t-Region-body").append(
    '<table id="picks">' +
    '<tr><td><input type="checkbox" id="pick_all"></td><td>All</td></tr>' +
    '<tr><td><input type="checkbox"></td><td>Tents</td></tr>' +
    '<tr><td><input type="checkbox"></td><td>Stoves</td></tr></table>');
const all = document.getElementById("pick_all");
all.checked = true;
const boxes = $f_CheckFirstColumn(all);
console.log(boxes.length, "checkboxes:", boxes.map((box) => box.checked));
