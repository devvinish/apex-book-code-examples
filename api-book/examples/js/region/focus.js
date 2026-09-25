// @page product-catalog
apex.region("catalog").focus();
console.log("focus is in:", apex.jQuery(document.activeElement).closest(".a-CardView-item").attr("data-id")
    ? "the first card" : document.activeElement.tagName);
