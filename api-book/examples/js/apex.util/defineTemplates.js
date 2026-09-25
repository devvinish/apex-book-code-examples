apex.util.defineTemplates([{
    name: "ORBIT.BADGE",
    template: `<span class="t-Badge #CLASS#">#LABEL#</span>`,
    args: [{ name: "LABEL", required: true }, { name: "CLASS", default: "u-color-1" }],
    defaultEscape: "HTML"
}]);
console.log(apex.util.getTemplateDef("ORBIT.BADGE").args);
console.log(apex.util.applyNamedTemplate("ORBIT.BADGE", { args: { LABEL: "Shipped & paid" } }));
// {with/}: each argument on a line of its own
console.log(apex.util.applyTemplate(`{with/}
LABEL:=&STATUS.
CLASS:=u-success
{apply ORBIT.BADGE/}`, { extraSubstitutions: { STATUS: "Approved" } }));
console.log(apex.util.applyTemplate(`{with/}LABEL:=&STATUS.{apply ORBIT.BADGE/}`,
                                    { extraSubstitutions: { STATUS: "Approved" } }));
