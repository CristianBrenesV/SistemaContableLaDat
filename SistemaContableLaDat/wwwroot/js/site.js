const INACTIVITY_TIMEOUT = 5 * 60 * 1000;
let inactivityTimer;

function resetTimer() {
    clearTimeout(inactivityTimer);
    inactivityTimer = setTimeout(() => {
        const modal = new bootstrap.Modal(document.getElementById('sessionExpiredModal'));
        modal.show();
    }, INACTIVITY_TIMEOUT);
}

['load', 'mousemove', 'keypress', 'click', 'scroll'].forEach(evt =>
    window.addEventListener(evt, resetTimer)
);
