/* Orbit Sales: shared JavaScript (Chapter 32) */
window.orbit = window.orbit || {};

(function (orbit) {
    'use strict';

    const money = new Intl.NumberFormat('en-US',
        { style: 'currency', currency: 'USD', maximumFractionDigits: 0 });

    // Formats a number as whole US dollars: 73499.05 -> "$73,499"
    orbit.formatMoney = (value) => money.format(value || 0);

    // Loads the customer summary of the Order form (Chapter 31)
    orbit.showCustomerInfo = function (customerItem, targetItem) {
        return apex.server.process('GET_CUSTOMER_INFO', {
            x01: apex.item(customerItem).getValue()
        }).then((data) => {
            apex.item(targetItem).setValue(
                'Credit limit ' + orbit.formatMoney(data.creditLimit) +
                ' · lifetime value ' + orbit.formatMoney(data.lifetimeValue) +
                ' · ' + data.openOrders +
                (data.openOrders === 1 ? ' open order' : ' open orders'));
        }).catch(() => {
            apex.message.showErrors([{
                type: 'error', location: 'page',
                message: 'Customer details could not be loaded.'
            }]);
        });
    };
})(window.orbit);
