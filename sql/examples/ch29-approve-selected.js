// Chapter 29: the Approve Selected Orders process in JavaScript (MLE)
const ids = (apex.env.P8_SELECTED_ORDERS || '').split(':').filter(Boolean);
for (const id of ids) {
    apex.conn.execute(
        'begin orb_sales.approve_order(p_order_id => :id); end;',
        { id: Number(id) });
}
