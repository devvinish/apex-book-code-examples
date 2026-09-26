const { UNIT } = apex.date;
const ago = (amount, unit) => apex.date.subtract(new Date(), amount, unit);
for (const [amount, unit] of [[30, UNIT.SECOND], [5, UNIT.MINUTE], [3, UNIT.HOUR], [2, UNIT.DAY], [7, UNIT.MONTH]]) {
    console.log(`${amount} ${unit}:`.padEnd(14), apex.date.since(ago(amount, unit)), "|", apex.date.since(ago(amount, unit), true));
}
console.log("in 2 days:".padEnd(14), apex.date.since(apex.date.add(new Date(), 2, UNIT.DAY)));
