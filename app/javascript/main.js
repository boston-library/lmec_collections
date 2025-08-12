document.addEventListener("turbo:load", () => {
  document.querySelectorAll('[data-bs-toggle="btns"] .btn').forEach(btn => {
    btn.addEventListener("click", () => {
      btn.parentElement.querySelectorAll(".active").forEach(active => {
        active.classList.remove("active");
      });
      btn.classList.add("active");
    });
  });

  const hash = window.location.hash;
  if (hash) {
    const targetTab = document.querySelector(`a[data-bs-toggle="tab"][href="${hash}"]`);
    if (targetTab) {
      const tabInstance = new bootstrap.Tab(targetTab);
      tabInstance.show();
    }
  }

  document.querySelectorAll('a[data-bs-toggle="tab"]').forEach(tabEl => {
    tabEl.addEventListener("shown.bs.tab", e => {
      if (history && history.replaceState) {
        history.replaceState({}, "", e.target.getAttribute("href"));
      }
    });
  });

  document.addEventListener("shown.bs.modal", e => {
    const autofocusEl = e.target.querySelector("[autofocus]");
    if (autofocusEl) autofocusEl.focus();
  });

  const toggleBtn = document.querySelector(".nav-offcavas-toggle");
  const navOffcanvas = document.querySelector(".nav-offcavas");
  const overlay = document.querySelector(".nav-offcavas-overlay");

  [toggleBtn, overlay].forEach(el => {
    if (el) {
      el.addEventListener("click", () => {
        if (navOffcanvas) {
          navOffcanvas.classList.toggle("expanded");
          const textSpan = toggleBtn?.querySelector(".text");
          if (textSpan) {
            textSpan.textContent = navOffcanvas.classList.contains("expanded") ? "Close" : "Menu";
          }
        }
      });
    }
  });
});
