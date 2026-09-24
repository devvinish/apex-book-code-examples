// Chapter 31: Execute JavaScript Code action of the Show Customer Info dynamic action (page 10)
const money = new Intl.NumberFormat('en-US',
    { style: 'currency', currency: 'USD', maximumFractionDigits: 0 });

apex.server.process('GET_CUSTOMER_INFO', {
    x01: apex.item('P10_CUSTOMER_ID').getValue()
}).then((data) => {
    apex.item('P10_CUSTOMER_INFO').setValue(
        'Credit limit ' + money.format(data.creditLimit) +
        ' · lifetime value ' + money.format(data.lifetimeValue) +
        ' · ' + data.openOrders +
        (data.openOrders === 1 ? ' open order' : ' open orders'));
}).catch((error) => {
    apex.message.showErrors([{
        type: 'error', location: 'page',
        message: 'Customer details could not be loaded.'
    }]);
});
