await apex.lang.loadMessages(["ORBIT_DISCOUNT_APPROVAL", "ORDER_P10ORDERNUMBER_HAS_BEEN_SUBMITTED"]);
console.log(apex.lang.formatMessage("ORBIT_DISCOUNT_APPROVAL", 15));                        // %0
console.log(apex.lang.formatMessage("ORDER_P10ORDERNUMBER_HAS_BEEN_SUBMITTED",
                                    { P10_ORDER_NUMBER: "<b>ORD-12283</b>" }));            // named
console.log(apex.lang.formatMessageNoEscape("ORDER_P10ORDERNUMBER_HAS_BEEN_SUBMITTED",
                                            { P10_ORDER_NUMBER: "<b>ORD-12283</b>" }));
