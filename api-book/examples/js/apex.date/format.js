const d = new Date(2026, 8, 23, 14, 30, 5);
console.log(apex.date.format(d));                          // the application's date format
console.log(apex.date.format(d, "Day, DD Month YYYY"));
console.log(apex.date.format(d, "fmDay, DD fmMonth YYYY \"at\" HH:MI AM"));
console.log(apex.date.format(d, "YYYY-MM-DD\"T\"HH24:MI:SS"));
console.log(apex.date.format(d, "DD.MM.YYYY", "de"));
try {
    apex.date.format(d, "DD. Month YYYY", "de");
} catch (e) {
    console.log("de, Month:", e.message);
}
