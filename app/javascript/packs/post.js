document.addEventListener("turbolinks:load", () => {
  const form = document.getElementById("filter-form");

  if (form) {
    // セレクトボックスでの自動送信を防止
    form.querySelectorAll("select").forEach(select => {
      select.addEventListener("change", (e) => {
        e.stopPropagation();
      });
    });

    // ローディング表示
    form.addEventListener("ajax:beforeSend", () => {
      const postsList = document.getElementById("posts-list");
      if (postsList) {
        postsList.innerHTML = `
          <div class="d-flex justify-content-center my-5">
            <div class="spinner-border text-success" role="status">
              <span class="visually-hidden">読み込み中...</span>
            </div>
          </div>`;
      }
    });
  }
});
