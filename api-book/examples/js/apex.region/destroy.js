// @page home
apex.region.create("welcome", { type: "WelcomeBanner" });
console.log("before:", apex.region.isRegion("welcome"));
apex.region.destroy("welcome");
console.log("after: ", apex.region.isRegion("welcome"), "- element still there:", $x("welcome") !== false);
