apex.lang.loadMessagesIfNeeded(["ORBIT_DISCOUNT_APPROVAL"], () => {
    console.log("first call:", apex.lang.formatMessage("ORBIT_DISCOUNT_APPROVAL", 15));
    apex.lang.loadMessagesIfNeeded(["ORBIT_DISCOUNT_APPROVAL"], () => console.log("second call: no request"));
});
