const { UNIT } = apex.date;
const a = new Date(2026, 8, 23, 9, 0), b = new Date(2026, 8, 23, 17, 45), c = new Date(2026, 9, 1);
console.log("isBefore:", apex.date.isBefore(a, b), "- same day:", apex.date.isBefore(a, b, UNIT.DAY));
console.log("isAfter:", apex.date.isAfter(c, b, UNIT.MONTH));
console.log("isSame:", apex.date.isSame(a, b), apex.date.isSame(a, b, UNIT.DAY));
console.log("isSameOrBefore:", apex.date.isSameOrBefore(a, b, UNIT.DAY),
            "- isSameOrAfter:", apex.date.isSameOrAfter(a, c, UNIT.YEAR));
console.log("isBetween:", apex.date.isBetween(b, a, c), apex.date.isBetween(a, a, c));
console.log("min:", apex.date.format(apex.date.min(b, c, a), "DD-MON HH24:MI"),
            "- max:", apex.date.format(apex.date.max(b, c, a), "DD-MON HH24:MI"));
