// @page stores
// The options of the Initialization JavaScript Function, as the grid received them:
const config = apex.region("stores").call("option", "config");
console.log("editable:", config.editable.allowedOperations.create, config.editable.allowedOperations.update,
            config.editable.allowedOperations.delete, "- autoAddRow:", config.editable.autoAddRow);
console.log("features:", Object.keys(config.features), "- download formats:", config.features.download.formats);
console.log("toolbar:", config.toolbar);
console.log("reportSettingsArea:", config.reportSettingsArea, "- initialSelection:", config.initialSelection,
            "- trackParentSelection:", config.trackParentSelection);
console.log("views:", Object.keys(config.views));
