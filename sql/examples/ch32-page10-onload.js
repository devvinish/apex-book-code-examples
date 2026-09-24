// Chapter 32: page 10, JavaScript > Execute when Page Loads
// New orders start with the customer
if (!apex.item('P10_ORDER_ID').getValue()) {
    apex.item('P10_CUSTOMER_ID').setFocus();
}

// Ctrl+Alt+S saves the order
apex.actions.add({
    name: 'orbit-save-order',
    label: 'Save Order',
    shortcut: 'Ctrl+Alt+S',
    action: () => apex.page.submit(
        apex.item('P10_ORDER_ID').getValue() ? 'SAVE' : 'CREATE')
});
