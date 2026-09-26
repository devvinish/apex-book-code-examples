const d = new Date(2026, 8, 23, 14, 30, 5);
console.log(apex.date.toISOString(d), "(apex.date: local time, no time zone)");
console.log(d.toISOString(), "(Date: UTC, here from India Standard Time)");
