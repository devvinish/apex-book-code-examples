const start = Date.now();
const onScroll = apex.util.throttle(() => console.log("handled at", Math.round((Date.now() - start) / 100) * 100, "ms"), 200);
const timer = setInterval(onScroll, 20);                          // 50 calls a second
await new Promise((resolve) => setTimeout(resolve, 650));
clearInterval(timer);
await new Promise((resolve) => setTimeout(resolve, 300));
