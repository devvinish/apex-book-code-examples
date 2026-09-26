const iso = (d) => apex.date.toISOString(d);
console.log(iso(apex.date.parse("23-SEP-2026 14:30", "DD-MON-YYYY HH24:MI")));
console.log(iso(apex.date.parse("9/23/2026")));                 // the application's date format
try {
    apex.date.parse("31-FEB-2026", "DD-MON-YYYY");
} catch (e) {
    console.log("31-FEB-2026:", e.message);
}
console.log(apex.date.isValid(new Date("x")), apex.date.isValid(new Date(2026, 8, 23)));
console.log(apex.date.isValidString("2026-09-23T14:30"), apex.date.isValidString("next Tuesday"));
