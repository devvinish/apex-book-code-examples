// @page product-categories
const ajaxIdentifier = apex.region("categories").call("option", "ajaxIdentifier") ??
    Object.values(apex.region("categories").widget().data()).find((w) => w.options?.ajaxIdentifier)?.options.ajaxIdentifier;
console.log("ajaxIdentifier:", ajaxIdentifier ? ajaxIdentifier.slice(0, 16) + "…" : ajaxIdentifier);
const url = apex.server.pluginUrl(ajaxIdentifier, { x01: "LAZY" });
console.log(url.replace(/p_instance=\d+/, "p_instance=…").replace(/p_request=PLUGIN%3D[^&]+/, "p_request=PLUGIN%3D…"));
