const l = apex.locale;
console.log("language:", l.getLanguage());
console.log("decimal:", l.getDecimalSeparator(), "- group:", l.getGroupSeparator());
console.log("currency:", l.getCurrency(), l.getISOCurrency(), l.getDualCurrency());
console.log("date formats:", l.getDateFormat(), "|", l.getDSDateFormat(), "|", l.getDLDateFormat());
console.log("days:", l.getDayNames().join(" "));
console.log("abbrev:", l.getAbbrevDayNames().join(" "), "|", l.getAbbrevMonthNames().join(" "));
console.log("months:", l.getMonthNames().slice(0, 3).join(" "), "…");
