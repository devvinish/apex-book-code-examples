// The spinner shows only if the work takes long enough, and then stays long enough not to flicker.
const run = async (label, ms) => {
    let spinner = null;
    const t0 = Date.now();
    apex.util.delayLinger.start(label, () => { spinner = apex.util.showSpinner(); console.log(label, "shown at", Math.round((Date.now() - t0) / 100) * 100, "ms"); });
    await new Promise((resolve) => setTimeout(resolve, ms));        // the work
    apex.util.delayLinger.finish(label, () => { spinner.remove(); console.log(label, "removed at", Math.round((Date.now() - t0) / 100) * 100, "ms"); });
    await new Promise((resolve) => setTimeout(resolve, 1500));
    if (!spinner) console.log(label, "no spinner");
};
await run("fast (100 ms)", 100);
await run("slow (1500 ms)", 1500);
