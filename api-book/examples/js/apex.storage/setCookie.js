apex.storage.setCookie("ORBIT_THEME", "dark");
console.log("getCookie:", apex.storage.getCookie("ORBIT_THEME"));
console.log("document.cookie has it:", document.cookie.includes("ORBIT_THEME=dark"));
console.log("missing cookie:", apex.storage.getCookie("NO_SUCH_COOKIE"));
