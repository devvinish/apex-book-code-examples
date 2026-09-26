// A button with data-menu opens the menu with that ID: no code needed.
apex.jQuery(`<div id="orbit_actions_menu"></div>`).appendTo("body").menu({
    items: [{ type: "action", label: "Duplicate", action: () => console.log("duplicate") },
            { type: "action", label: "Delete", action: () => console.log("delete") }]
});
apex.jQuery("#recent_orders .t-Region-headerItems--buttons")
    .append(`<button type="button" class="t-Button" data-menu="orbit_actions_menu" aria-haspopup="menu" aria-expanded="false">Actions</button>`);
const button = apex.jQuery("[data-menu='orbit_actions_menu']");
button.trigger("click");
await new Promise((resolve) => setTimeout(resolve, 300));
console.log("menu open:", apex.jQuery("#orbit_actions_menu").is(":visible"), "- aria-expanded:", button.attr("aria-expanded"));
