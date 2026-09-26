const name = `O'Brien & Sons <script>alert("x")</script>`;
console.log(apex.util.escapeHTML(name));
console.log(apex.util.escapeHTMLAttr(name));
console.log(apex.util.stripHTML("<p>Order <b>ORD-12283</b> was <em>shipped</em>.</p>"));
console.log("#" + apex.util.escapeCSS("order#12:new"));
