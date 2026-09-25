let period = "WEEK";
apex.jQuery("#recent_orders .t-Region-headerItems--buttons").append(`<select data-action="orbit-period"></select>`);
apex.actions.add({
    name: "orbit-period",
    label: "Period",
    choices: [{ label: "Today", value: "DAY" }, { label: "This Week", value: "WEEK" }, { label: "This Month", value: "MONTH" }],
    get: () => period,
    set: (value) => { period = value; console.log("set:", value); }
});
const select = apex.jQuery("select[data-action='orbit-period']");
console.log("select options:", select.find("option").map((i, o) => o.textContent).get().join(", "), "- selected:", select.val());
apex.actions.set("orbit-period", "MONTH");
console.log("get:", apex.actions.get("orbit-period"), "- select:", select.val());
apex.actions.lookup("orbit-period").choices.push({ label: "This Year", value: "YEAR" });
apex.actions.updateChoices("orbit-period");
console.log("after updateChoices:", select.find("option").length, "options");
