// @page product-catalog
// Loop over the records of the cards region's model; &SKU., &PRODUCT_NAME., and &PRICE. are its columns.
const out = apex.util.applyTemplate(`{loop catalog/}&APEX$I.. &SKU. &PRODUCT_NAME. &PRICE.\n{endloop/}`);
console.log(out.split("\n").slice(0, 3).join("\n"));
