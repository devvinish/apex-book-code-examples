// @page products
const search = apex.region("product_search");
const pause = (ms) => new Promise((resolve) => setTimeout(resolve, ms));
search.on("facetsbeforeaddchart facetsafterremovechart", (event, data) =>
    console.log(event.type, data.chartName, "- charts:", data.count));
search.addChart("P4_COLOR");
await pause(1500);
search.removeChart("P4_COLOR");
await pause(500);
