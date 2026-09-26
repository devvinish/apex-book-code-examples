const { UNIT } = apex.date;
const ordered = new Date(2026, 8, 23, 14, 30);            // 23 September 2026, 14:30
const due = apex.date.add(apex.date.clone(ordered), 3, UNIT.DAY);
console.log("ordered:", apex.date.format(ordered, "DD-MON-YYYY HH24:MI"));
console.log("due:    ", apex.date.format(due, "DD-MON-YYYY HH24:MI"));
apex.date.subtract(due, 2, UNIT.HOUR);
console.log("minus 2 hours:", apex.date.format(due, "DD-MON-YYYY HH24:MI"));
apex.date.add(ordered, 1, UNIT.MONTH);                    // without clone: changes the original
console.log("ordered is now:", apex.date.format(ordered, "DD-MON-YYYY"));
console.log(UNIT);
