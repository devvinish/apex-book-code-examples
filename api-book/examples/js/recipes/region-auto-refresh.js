// @page home
// === Page › Function and Global Variable Declaration ===
// Refreshes a region every few seconds while the browser tab is visible, and shows when it
// was last refreshed after the region's title. Returns a function that stops it.
function autoRefresh(regionId, seconds) {
    const region = apex.region(regionId);
    const stamp$ = $("<small class='u-color-text-muted'></small>")
        .appendTo(region.element.find(".t-Region-title").first());
    const timer = setInterval(async () => {
        if (document.visibilityState !== "visible") return;       // not while the tab is hidden
        await region.refresh();                                     // a promise (Chapter 5)
        stamp$.text(" · updated " + new Date().toLocaleTimeString("en-US"));
    }, seconds * 1000);
    return () => clearInterval(timer);
}
// === Page › Execute when Page Loads ===
const stopRefresh = autoRefresh("recent_orders", 60);
// === Try it: refresh every 2 seconds instead, and stop after three refreshes ===
stopRefresh();
const stop = autoRefresh("recent_orders", 2);
const title$ = apex.region("recent_orders").element.find(".t-Region-title").first();
for (let second = 1; second <= 6; second++) {
    await new Promise((resolve) => setTimeout(resolve, 1000));
    if (second % 2 === 0) console.log(`after ${second} s:`, title$.text());
}
stop();
