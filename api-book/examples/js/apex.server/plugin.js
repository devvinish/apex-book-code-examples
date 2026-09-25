// @page products
// Native regions call their PL/SQL Ajax function with apex.server.plugin; watch the facets region do it.
const original = apex.server.plugin;
apex.server.plugin = function (ajaxIdentifier, data, options) {
    console.log("plugin:", typeof ajaxIdentifier === "string" ? ajaxIdentifier.slice(0, 12) + "…" : "(in data.regions)",
                "- data:", Object.keys(data || {}).join(", "));
    return original.apply(this, arguments);
};
const done = apex.region("product_search").fetchCounts();
await new Promise((resolve) => setTimeout(resolve, 1500));
apex.server.plugin = original;
