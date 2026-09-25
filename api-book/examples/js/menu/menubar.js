// @shot #orbit_menubar
apex.jQuery(`<div id="orbit_menubar"></div>`).insertBefore("#recent_orders").menu({
    menubar: true, behaveLikeTabs: true, menubarOverflow: true,
    items: [
        { type: "action", id: "home", label: "Home", href: "#", current: true },
        { type: "subMenu", id: "sales", label: "Sales", menu: { items: [
            { type: "action", label: "Orders", href: "#" }, { type: "action", label: "Customers", href: "#" }] } },
        { type: "action", id: "reports", label: "Reports", href: "#" }
    ]
});
const bar$ = apex.jQuery("#orbit_menubar");
bar$.menu("setCurrentMenuItem", bar$.menu("find", "reports"));
bar$.menu("refresh");
console.log("current:", bar$.find("[aria-current=true]").text());
bar$.menu("resize");
