function( options ) {
    // A thinner ring, and the total in the middle of the donut
    options.styleDefaults = options.styleDefaults || {};
    options.styleDefaults.pieInnerRadius = 0.7;
    options.pieCenter = { label: "All channels" };
    return options;
}
