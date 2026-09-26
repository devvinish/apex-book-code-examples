const f = apex.locale.formatNumber;
console.log(f(1234567.891));
console.log(f(1234567.891, "FML999G999G990D00"));
console.log(f(-42.5, "999G990D00MI"));
console.log(f(1234.5, "L99G999D99PR"), f(-1234.5, "L99G999D99PR"));
console.log(f(1234567.891, "999G999G990D00", { NLS_NUMERIC_CHARACTERS: ",." }));
console.log(f(9.95, "C990D00", { NLS_ISO_CURRENCY: "EUR" }));
