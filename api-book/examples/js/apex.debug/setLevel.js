const { LOG_LEVEL } = apex.debug;
console.log("level:", apex.debug.getLevel(), LOG_LEVEL);
apex.debug.info("not written: the level is", apex.debug.getLevel());
apex.debug.setLevel(LOG_LEVEL.INFO);
apex.debug.info("written at level", apex.debug.getLevel());
apex.debug.trace("not written: APP_TRACE is 6");
apex.debug.setLevel(LOG_LEVEL.OFF);
apex.debug.error("error() always writes, even when logging is off");
