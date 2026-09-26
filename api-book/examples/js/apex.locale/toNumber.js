const t = apex.locale.toNumber;
console.log(t("1,234,567.89"));
console.log(t("$1,234.50", "FML999G990D00"));
console.log(t("42-", "990MI"));
console.log(t("abc"));
