document.addEventListener("turbolinks:load", function() {
  const filterForm = document.getElementById("filter-form");
  if (!filterForm) return;

  filterForm.addEventListener("change", function() {
    filterForm.requestSubmit();
  });
});