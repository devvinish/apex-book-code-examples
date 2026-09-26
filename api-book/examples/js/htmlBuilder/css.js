const out = apex.util.htmlBuilder();
out.markup("<div").attr("class", "orbit-bar").css("width", "42%").css("color", null).markup("></div>");
console.log(out.toString());                              // a data attribute, not a style attribute
const bar$ = out.toJquery();
console.log(bar$[0].outerHTML, "- style width:", bar$[0].style.width);
