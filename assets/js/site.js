(function () {
  var btn = document.getElementById('theme-toggle');
  if (!btn) return;

  function syncLabel() {
    var isDark = document.documentElement.getAttribute('data-theme') === 'dark';
    btn.setAttribute('aria-label', isDark ? 'Switch to light theme' : 'Switch to dark theme');
  }

  btn.addEventListener('click', function () {
    var isDark = document.documentElement.getAttribute('data-theme') === 'dark';
    if (isDark) {
      document.documentElement.removeAttribute('data-theme');
      localStorage.setItem('theme', 'light');
    } else {
      document.documentElement.setAttribute('data-theme', 'dark');
      localStorage.setItem('theme', 'dark');
    }
    syncLabel();
  });

  syncLabel();
})();
