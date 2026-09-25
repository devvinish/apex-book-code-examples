apex.debug.setLevel(apex.debug.LOG_LEVEL.APP_TRACE);
apex.debug.message(apex.debug.LOG_LEVEL.INFO, "message at INFO:", { orderId: 2282 });
apex.debug.log("log: the highest level");
apex.debug.warn("warn: order total is negative");
apex.debug.info("info: 6 orders loaded");
apex.debug.trace("trace: entering refreshOrders");
apex.debug.message(apex.debug.LOG_LEVEL.ENGINE_TRACE, "not written: ENGINE_TRACE is 9");
