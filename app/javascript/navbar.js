document.addEventListener("turbo:load", () => {
  const searchToggle = document.querySelector("[data-search-toggle]");
  const navbarSearch = document.querySelector(".navbar-search");
  const searchInput = document.getElementById("q");

  if (searchToggle && navbarSearch) {
    searchToggle.addEventListener("click", () => {
      searchToggle.classList.toggle("active");
      navbarSearch.classList.toggle("active");
      if (searchInput) searchInput.focus();
    });
  }

  document.addEventListener("mouseup", (e) => {
    if (navbarSearch && !navbarSearch.contains(e.target) && !searchToggle.contains(e.target)) {
      searchToggle.classList.remove("active");
      navbarSearch.classList.remove("active");
    }
  });

  document.querySelectorAll("[data-search-action]").forEach(link => {
    link.addEventListener("click", (e) => {
      e.preventDefault();

      const form = link.closest("form");
      const name = link.dataset.searchName;

      if (name) {
        const textInput = form.querySelector('input[type="text"]');
        if (textInput) textInput.setAttribute("name", name);
      }

      form.setAttribute("action", link.getAttribute("href"));
      form.submit();
    });
  });
});
