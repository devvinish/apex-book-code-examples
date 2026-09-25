apex.lang.addMessages({
    "ORBIT.CART.ITEMS": "%0 items in your cart",
    "ORBIT.CART.EMPTY": "Your cart is empty"
});
console.log(apex.lang.formatMessage("ORBIT.CART.ITEMS", 3));
console.log(apex.lang.hasMessage("ORBIT.CART.EMPTY"), apex.lang.getMessage("ORBIT.CART.EMPTY"));
apex.lang.clearMessages();
console.log("after clearMessages:", apex.lang.hasMessage("ORBIT.CART.EMPTY"),
            apex.lang.hasMessage("APEX.DIALOG.OK"));
