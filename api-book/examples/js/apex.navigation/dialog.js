// @page customers
// A dialog URL must come from the server, with its checksums: take the one of the
// report's link to the first customer.
const link = apex.jQuery("#customers a[href*='dialog-open']").first().attr("href");
const url = new URLSearchParams(link.split("?")[1]).get("url");
apex.navigation.dialog(url, { title: "Customer", modal: true, width: 900, height: 600 }, "t-Dialog-page--standard", "#customers");
await new Promise((resolve) => setTimeout(resolve, 3000));
const frame = document.querySelector(".ui-dialog iframe");
console.log("dialog:", apex.jQuery(".ui-dialog-title").text(), "- page", frame.contentWindow.apex.env.APP_PAGE_ID);
const $v = frame.contentWindow.apex.item;
console.log("customer:", $v("P3_FIRST_NAME").getValue(), $v("P3_LAST_NAME").getValue(), "-", $v("P3_EMAIL").getValue());
