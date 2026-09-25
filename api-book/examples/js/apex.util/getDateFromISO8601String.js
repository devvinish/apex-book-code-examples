const d = apex.util.getDateFromISO8601String("2026-09-23T14:30:00Z");
console.log(d.toISOString());
console.log(apex.util.getDateFromISO8601String("2026-09-23").toISOString());
