// Chapter 31: Execute JavaScript Code action of the Poll Recalculation dynamic action (page 8, Page Load)
function checkProgress() {
    apex.server.process('GET_RECALC_PROGRESS').then((data) => {
        if (data.done) {
            apex.message.showPageSuccess('Recalculation ' + data.status.toLowerCase() +
                ': ' + data.sofar.toLocaleString() + ' orders.');
        } else {
            apex.message.showPageSuccess(data.totalwork
                ? 'Recalculating order totals: ' + data.sofar.toLocaleString() +
                  ' of ' + data.totalwork.toLocaleString() + ' orders…'
                : 'Recalculation: ' + data.status + '…');
            setTimeout(checkProgress, 1000);
        }
    });
}
checkProgress();
