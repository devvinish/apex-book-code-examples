// @page customer-overview
const about = apex.jQuery(".t-Region--hideShow").first();     // the collapsible "About This Page"
const state = () => about.hasClass("is-expanded") ? "expanded" : "collapsed";
apex.theme.closeRegion(about);
console.log("after closeRegion:", state());
apex.theme.openRegion(about);
console.log("after openRegion: ", state());
