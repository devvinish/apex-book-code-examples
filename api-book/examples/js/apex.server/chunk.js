const text = "x".repeat(20000);
const chunks = apex.server.chunk(text);
console.log(Array.isArray(chunks), chunks.map((c) => c.length));
console.log(apex.server.chunk("short text"));
// send long text in f01, which the process reads as apex_application.g_f01(1..n)
console.log(Object.keys({ f01: chunks }));
