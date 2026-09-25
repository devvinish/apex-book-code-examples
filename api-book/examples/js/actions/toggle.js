let compact = false;
// the element comes first: APEX binds data-action elements when the action is added
apex.jQuery("#recent_orders .t-Region-headerItems--buttons")
    .append(`<button type="button" class="t-Button" id="compact_btn" data-action="orbit-compact"></button>`);
apex.actions.add({
    name: "orbit-compact",
    label: "Compact View",
    get: () => compact,
    set: (value) => { compact = value; apex.jQuery("#recent_orders").toggleClass("orbit-compact", value); }
});
const state = () => `value ${apex.actions.get("orbit-compact")}, button active ${apex.jQuery("#compact_btn").hasClass("is-active")}`;
console.log("start:      ", state());
apex.actions.toggle("orbit-compact");
console.log("toggle():   ", state());
apex.actions.set("orbit-compact", false);
console.log("set(false): ", state());
apex.jQuery("#compact_btn").trigger("click");              // the user clicks the button
console.log("user click: ", state());
