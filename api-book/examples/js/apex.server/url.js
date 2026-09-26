// @page products
const show = (url) => console.log(url.replace(/p_instance=\d+/, "p_instance=…"));
show(apex.server.url({ p_request: "APPLICATION_PROCESS=ORDER_SUMMARY", x01: "2282" }));
show(apex.server.url({ p_request: "APPLICATION_PROCESS=ORDER_SUMMARY", x01: "2282" }, "1"));
const response = await fetch(apex.server.url({ p_request: "APPLICATION_PROCESS=ORDER_SUMMARY", x01: "2282" }));
console.log("GET:", (await response.json()).orderNumber);
