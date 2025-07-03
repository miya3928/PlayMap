document.addEventListener("turbolinks:load", () => {
  // 返信フォームの表示・非表示切り替え
  document.querySelectorAll("[data-toggle^='reply-form-']").forEach(btn => {
    btn.addEventListener("click", function(e) {
      e.preventDefault();
      const id = btn.dataset.toggle;
      const form = document.getElementById(id);
      if (form) form.style.display = (form.style.display === "none") ? "block" : "none";
    });
  });

  // 返信の折りたたみ切り替え
  document.querySelectorAll(".toggle-replies").forEach(btn => {
    btn.addEventListener("click", function(e) {
      e.preventDefault();
      const targetId = btn.dataset.target;
      const repliesBox = document.getElementById(targetId);
      if (repliesBox) {
        const isHidden = repliesBox.style.display === "none";
        repliesBox.style.display = isHidden ? "block" : "none";
        btn.innerHTML = isHidden ? "▼ 返信を非表示" : "▶ 返信を表示";
      }
    });
  });
});