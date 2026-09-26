// @page customers
const spinner = apex.util.showSpinner("#customers", { alert: "Loading customers" });
console.log("spinner:", spinner.attr("class"), "- role:", spinner.attr("role"));
await new Promise((resolve) => setTimeout(resolve, 300));
