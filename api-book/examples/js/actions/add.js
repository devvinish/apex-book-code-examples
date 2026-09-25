// A button bound to an action: data-action names it.
apex.jQuery("#recent_orders .t-Region-headerItems--buttons")
    .append(`<button type="button" class="t-Button" data-action="orbit-refresh-orders"></button>`);
apex.actions.add({
    name: "orbit-refresh-orders",
    label: "Refresh Orders",
    title: "Get the latest orders",
    shortcut: "Alt+Shift+R",
    action: (event, focusElement, args) => {
        console.log("action: refreshing", args.region);
        apex.region(args.region).refresh();
    }
});
const button = apex.jQuery("[data-action='orbit-refresh-orders']");
console.log("button:", button.text(), "- title:", button.attr("title"));
apex.actions.invoke("orbit-refresh-orders", null, null, { region: "recent_orders" });
console.log(apex.actions.lookup("orbit-refresh-orders").shortcut);
