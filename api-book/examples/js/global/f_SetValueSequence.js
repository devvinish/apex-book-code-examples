// @page item-types
apex.jQuery("#text_items .t-Region-body").append(
    '<div id="steps"><input class="seq"><input class="seq"><input class="seq"></div>');
const inputs = apex.jQuery("#steps .seq").get();
$f_SetValueSequence(inputs, 10);
console.log(inputs.map((input) => input.value));
