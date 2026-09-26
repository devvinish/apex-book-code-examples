// @page products
// @shot .ui-dialog:has(.a-FS-chartsDialog)
const search = apex.region("product_search");
search.on("facetsbeforeaddchart facetsafterremovechart", (event, data) =>
    console.log(event.type, data.chartName, "- charts:", data.count));
search.addChart("P4_COLOR", null, { type: "bar", topN: 5 });
await new Promise((resolve) => setTimeout(resolve, 1500));
