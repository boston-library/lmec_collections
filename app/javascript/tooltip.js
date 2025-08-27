document.addEventListener("turbo:load", () => {
  document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach((el) => {
    new bootstrap.Tooltip(el)
  })
})
