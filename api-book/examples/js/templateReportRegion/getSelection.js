// @shot #recent_orders .t-Region-bodyWrap
// @setup apex.jQuery("#t_Header").hide()
const orders = apex.region("recent_orders");
const rows$ = orders.element.find("[data-id]");
orders.setSelection(rows$.slice(1, 3));                  // the second and third row
orders.getSelection().each((i, row) => console.log(row.dataset.id,
    row.querySelector(".t-ContentRow-overline").textContent,
    row.querySelector(".t-ContentRow-title").textContent));
