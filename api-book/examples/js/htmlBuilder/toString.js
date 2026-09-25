const status = `Shipped & "paid"`;
const out = apex.util.htmlBuilder();
out.markup("<span")
   .attr("class", "t-Badge")
   .optionalAttr("title", status)
   .optionalAttr("data-empty", "")                       // left out: empty
   .optionalBoolAttr("hidden", false)                    // left out: false
   .markup(">")
   .content(status)
   .markup("</span>");
console.log(out.toString());
out.clear();
console.log("after clear:", JSON.stringify(out.toString()));
