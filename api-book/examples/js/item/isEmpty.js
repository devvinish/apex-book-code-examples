// @page item-types
console.log(apex.item("P20_TEXT").isEmpty());
apex.item("P20_TEXT").setValue("   ");
console.log(apex.item("P20_TEXT").isEmpty());         // only spaces count as empty
console.log(apex.item("P20_PASSWORD").isEmpty());
