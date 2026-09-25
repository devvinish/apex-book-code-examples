// @page item-types
// A minimal item plug-in: a span that holds a rating from 1 to 5
apex.jQuery("#text_items .t-Region-body").append('<span id="P20_STARS" class="stars">3</span>');

apex.item.create("P20_STARS", {
    item_type: "STARS",
    getValue: function () {
        return this.element.text();
    },
    setValue: function (value) {
        this.element.text(value);
    },
    isChanged: function () {
        return this.element.text() !== "3";
    }
});

const stars = apex.item("P20_STARS");
console.log(stars.item_type, "value:", stars.getValue(), "changed:", stars.isChanged());
stars.setValue("5");
console.log("value:", $v("P20_STARS"), "changed:", stars.isChanged());
