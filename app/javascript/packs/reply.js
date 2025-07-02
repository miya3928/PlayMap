document.addEventListener("turbo:load", () => {
  document.querySelectorAll("[data-toggle^='reply-form-']").forEach(btn => {
    btn.addEventListener("click", function(e) {
      e.preventDefault();
      const id = btn.dataset.toggle;
      const form = document.getElementById(id);
      if (form) form.style.display = (form.style.display === "none") ? "block" : "none";
    });
  });
});