// @page item-types
console.log("jQuery version:", apex.jQuery.fn.jquery);
console.log("items on the page:", Object.keys(apex.items).length);
console.log("first five:", Object.keys(apex.items).slice(0, 5));
console.log("regions:", Object.keys(apex.regions));
console.log("text fields in the page context:",
    apex.jQuery("input[type=text]", apex.gPageContext$).length);
