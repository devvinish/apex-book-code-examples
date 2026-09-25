console.log(apex.lang.format("%0 of %1 orders are %2.", 3, 12, "<b>late</b>"));
console.log(apex.lang.formatNoEscape("%0 of %1 orders are %2.", 3, 12, "<b>late</b>"));
console.log(apex.lang.format("Hello %name, you have %count new tasks.", { name: "Ada", count: 2 }));
console.log(apex.lang.format("100%% of %0", "orders"));
