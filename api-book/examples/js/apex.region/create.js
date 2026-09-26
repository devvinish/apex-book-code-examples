// @page home
// give the static Welcome region a region interface of its own
let refreshed = 0;
apex.region.create("welcome", {
    type: "WelcomeBanner",
    refresh: function () {
        refreshed += 1;
        this.element.find(".t-Region-title").text("Welcome back (" + refreshed + ")");
        return Promise.resolve();
    }
});
const welcome = apex.region("welcome");
console.log(welcome.type);
await welcome.refresh();
console.log(welcome.element.find(".t-Region-title").text());
