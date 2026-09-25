// @shot #orbit_menu
let compact = false, sort = "DATE";
apex.jQuery(`<div id="orbit_menu"></div>`).appendTo("body").menu({
    items: [
        { type: "action", label: "Refresh", icon: "fa fa-refresh", accelerator: "Alt+R", action: () => console.log("action: refresh") },
        { type: "toggle", label: "Compact View", get: () => compact, set: (v) => { compact = v; console.log("toggle:", v); } },
        { type: "separator" },
        { type: "radioGroup", get: () => sort, set: (v) => { sort = v; console.log("radio:", v); },
          choices: [{ label: "Newest First", value: "DATE" }, { label: "Largest First", value: "TOTAL" }] },
        { type: "subMenu", label: "Export", menu: { items: [
            { type: "action", label: "CSV", action: () => console.log("export CSV") },
            { type: "action", id: "pdf", label: "PDF", disabled: true, action: () => {} }] } },
        { type: "action", label: "Help", href: "https://docs.oracle.com/en/database/oracle/apex/26.1/", target: "_blank" }
    ]
});
const menu$ = apex.jQuery("#orbit_menu");
menu$.on("menubeforeopen", () => console.log("beforeOpen"));
menu$.on("menuafterclose", (event, data) => console.log("afterClose, action taken:", data.actionTookFocus !== undefined));
const button = apex.jQuery("#recent_orders .t-Region-headerItems--buttons").append(`<button type="button" id="orbit_menu_btn" class="t-Button">Menu</button>`).find("#orbit_menu_btn");
menu$.menu("toggle", button);                              // open it below the button
console.log("find(pdf):", menu$.menu("find", "pdf").label, "- disabled:", menu$.menu("find", "pdf").disabled);
