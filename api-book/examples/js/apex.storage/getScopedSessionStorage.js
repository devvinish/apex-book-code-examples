const state = apex.storage.getScopedSessionStorage({ prefix: "orbit", usePageId: false });
state.setItem("lastOrder", "2282");
console.log("prefix:", state.prefix, "- lastOrder:", state.getItem("lastOrder"));
console.log("sessionStorage:", Object.keys(sessionStorage).filter((k) => k.startsWith("orbit")));
