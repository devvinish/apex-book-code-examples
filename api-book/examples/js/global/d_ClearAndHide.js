// @page item-types
apex.jQuery("#text_items .t-Region-body").prepend('<p id="promo">Free shipping this week</p>');
$d_ClearAndHide("promo");
const promo = document.getElementById("promo");
console.log("content:", JSON.stringify(promo.innerHTML), "- display:", promo.style.display);
