// @page item-types
const number = apex.item("P20_NUMBER");
console.log(number.id, "is a", number.item_type, "item with the value", number.getValue());

// apex.items holds the same interface
console.log(apex.items.P20_NUMBER === number);

// an item that is not on the page: the interface exists, its node is false
console.log("node of a missing item:", apex.item("P20_NO_SUCH_ITEM").node);
