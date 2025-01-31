document.addEventListener("turbo:load", function() {
  document.querySelectorAll(".filter-select").forEach(select => {
    select.addEventListener("change", function() {
      document.getElementById("filter-form").submit();
    });
  });
});