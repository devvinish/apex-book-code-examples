const popup = apex.widget.waitPopup();
console.log("overlay:", apex.jQuery(".u-Processing").length > 0 || apex.jQuery("#apex_wait_overlay").length > 0);
await new Promise((resolve) => setTimeout(resolve, 500));
setTimeout(() => popup.remove(), 2000);
console.log("remove:", typeof popup.remove);
