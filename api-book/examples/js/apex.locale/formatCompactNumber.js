await apex.locale.resourcesLoaded();
for (const n of [950, 123400, 1234000, 2500000000]) {
    console.log(n, "->", apex.locale.formatCompactNumber(n), "|",
                apex.locale.formatCompactNumber(n, { maximumFractionDigits: 0 }));
}
