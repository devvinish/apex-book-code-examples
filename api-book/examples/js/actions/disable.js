apex.actions.add({ name: "orbit-export", label: "Export", action: () => console.log("exporting") });
apex.jQuery("#recent_orders .t-Region-headerItems--buttons")
    .append(`<button type="button" class="t-Button" data-action="orbit-export"></button>`);
const button = apex.jQuery("[data-action='orbit-export']");
apex.actions.disable("orbit-export");
console.log("disabled:", button.prop("disabled"));
console.log("invoke while disabled:", apex.actions.invoke("orbit-export"));
apex.actions.enable("orbit-export");
apex.actions.hide("orbit-export");
console.log("visible:", button.is(":visible"));
apex.actions.show("orbit-export");
console.log("visible:", button.is(":visible"));
const action = apex.actions.lookup("orbit-export");
action.label = "Export CSV";
apex.actions.update("orbit-export");
console.log("label after update:", button.text());
