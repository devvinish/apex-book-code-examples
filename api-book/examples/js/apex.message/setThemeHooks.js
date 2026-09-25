apex.message.setThemeHooks({
    beforeShow: (msgType, element$) => {
        console.log("beforeShow:", msgType, element$.attr("id"));
        if (msgType === apex.message.TYPE.SUCCESS) {
            console.log("showing my own notification instead");
            return false;                                 // skip the theme's success message
        }
    }
});
apex.message.showPageSuccess("Order saved.");
console.log("theme message visible:", apex.jQuery("#t_Alert_Success").is(":visible"));
