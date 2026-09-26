const row = (label, value) => apex.util.htmlBuilder().markup("<dt>").content(label).markup("</dt><dd>").content(value).markup("</dd>");
const list = apex.util.htmlBuilder().markup("<dl>");
list.append(row("Order", "ORD-12283")).append(row("Total", "$463.21")).markup("</dl>");
console.log(list.toString());
