document.addEventListener("turbolinks:load", function() {
  const filterForm = document.getElementById("filter-form");
  if (!filterForm) return; // フォームが存在しない場合は処理を中断

  document.querySelectorAll(".filter-select").forEach(select => {
    select.addEventListener("change", function() {
      filterForm.submit();
    });
  });
});