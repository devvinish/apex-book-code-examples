// @page item-types
apex.item("P20_TEXT").element.on("change", () => console.log("change event, new value:", $v("P20_TEXT")));

apex.item("P20_TEXT").setValue("Summit Down Sleeping Bag");
apex.item("P20_TEXT").setValue("Trail Runner Pack", null, true);   // no change event
console.log("value now:", $v("P20_TEXT"));

apex.item("P20_SELECT_MANY").setValue(["1", "3"]);                  // several values
console.log("select many:", apex.item("P20_SELECT_MANY").getValue());
