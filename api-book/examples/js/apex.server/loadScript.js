console.log("before:", typeof apex.jQuery.fn.iconList);
apex.server.loadScript({ path: apex.env.APEX_FILES + "libraries/apex/minified/widget.iconList.min.js" },
                       () => console.log("after: ", typeof apex.jQuery.fn.iconList));
await new Promise((resolve) => setTimeout(resolve, 1500));
