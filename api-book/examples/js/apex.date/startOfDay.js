const d = new Date(2026, 8, 23, 14, 30, 5);
const f = (x) => apex.date.format(x, "DD-MON-YYYY HH24:MI:SS");
console.log("startOfDay:", f(apex.date.startOfDay(d)));
console.log("endOfDay:  ", f(apex.date.endOfDay(d)));
console.log("dayOfWeek:", apex.date.dayOfWeek(d), "- getDayOfYear:", apex.date.getDayOfYear(d),
            "- secondsPastMidnight:", apex.date.secondsPastMidnight(d));
const first = apex.date.clone(d);
console.log("setDayOfYear returns:", apex.date.setDayOfYear(first, 1));
console.log("the date is now:", f(first));
