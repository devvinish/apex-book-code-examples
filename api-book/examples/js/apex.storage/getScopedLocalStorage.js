const prefs = apex.storage.getScopedLocalStorage({ prefix: "orbit", useAppId: true, usePageId: true, regionId: "recent_orders" });
console.log("prefix:", prefs.prefix);
prefs.setItem("pageSize", "12");
prefs.setItem("sort", "ORDER_DATE desc");
console.log("length:", prefs.length, "- key(0):", prefs.key(0), "- pageSize:", prefs.getItem("pageSize"));
console.log("in localStorage:", Object.keys(localStorage).filter((k) => k.startsWith("orbit")));
prefs.removeItem("sort");
localStorage.setItem(prefs.prefix + ".extra", "added directly");      // behind the wrapper's back
console.log("length:", prefs.length);
prefs.sync();
console.log("after sync:", prefs.length);
prefs.clear();
console.log("after clear:", prefs.length, Object.keys(localStorage).filter((k) => k.startsWith("orbit")));
