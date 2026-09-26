const d = new Date(2026, 1, 17);                           // 17 February 2026
const f = (x) => apex.date.format(x, "DD-MON-YYYY");
console.log("firstOfMonth:", f(apex.date.firstOfMonth(d)), "- lastOfMonth:", f(apex.date.lastOfMonth(d)));
console.log("daysInMonth:", apex.date.daysInMonth(d), "- leap year:", apex.date.isLeapYear(d),
            apex.date.isLeapYear(new Date(2028, 0, 1)));
console.log("weekOfMonth:", apex.date.weekOfMonth(d), "- ISOWeek:", apex.date.ISOWeek(d));
console.log("monthsBetween:", apex.date.monthsBetween(new Date(2026, 8, 23), d));
