console.log("loaded before:", apex.lang.hasMessage("ORBIT_DISCOUNT_APPROVAL"));
await apex.lang.loadMessages(["ORBIT_DISCOUNT_APPROVAL", "ORDER_P10ORDERNUMBER_HAS_BEEN_%"]);
console.log("loaded after: ", apex.lang.hasMessage("ORBIT_DISCOUNT_APPROVAL"));
console.log(apex.lang.getMessage("ORDER_P10ORDERNUMBER_HAS_BEEN_CANCELLED"));
console.log(apex.lang.getMessage("NO_SUCH_MESSAGE"));
