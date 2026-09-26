// @page home
// @wait 1200
apex.jQuery(window).on("apexwindowresized", function () {
    console.log("done resizing:", apex.jQuery(window).width(), "x", apex.jQuery(window).height());
});
window.dispatchEvent(new Event("resize"));   // as when the user resizes the window
