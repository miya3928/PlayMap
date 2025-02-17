document.addEventListener("turbolinks:load", function() {
  console.log("filters.js loaded");
  const filterForm = document.getElementById("filter-form");
  if (!filterForm) return;

  filterForm.addEventListener("change", function() {
    filterForm.requestSubmit();
  });
});