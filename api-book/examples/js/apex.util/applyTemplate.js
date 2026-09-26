// @page item-types
const template = `<b>&P20_TEXT.</b> (&P20_TEXT%LABEL.) for &APP_USER. on page &APP_PAGE_ID. #NOTE#
{if ?P20_NUMBER/}Number: &P20_NUMBER.{else/}No number{endif/}
{case STATUS/}{when SHIPPED/}On its way{when CANCELLED/}Cancelled{otherwise/}Open{endcase/}
{loop "," COLORS/}[&APEX$I. &APEX$ITEM.]{endloop/} {!a comment/}&ORDER_NO!HTML.`;
console.log(apex.util.applyTemplate(template, {
    placeholders: { NOTE: "(a placeholder)", STATUS: "SHIPPED", COLORS: "Red,Olive,Sand" },
    extraSubstitutions: { ORDER_NO: "<ORD-12283>" }
}));
