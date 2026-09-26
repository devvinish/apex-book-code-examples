const observer = (action, operation) => console.log("observed:", operation, action.name);
apex.actions.observe(observer);
apex.actions.add({ name: "orbit-print", label: "Print", action: () => window.print() });
apex.actions.disable("orbit-print");
apex.actions.remove("orbit-print");
apex.actions.unobserve(observer);
apex.actions.add({ name: "orbit-print", label: "Print", action: () => window.print() });
console.log("after unobserve: nothing observed");
