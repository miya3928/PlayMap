document.addEventListener("turbolinks:load", function () {
  const previewImage = (inputSelector, previewSelector) => {
    const input = document.querySelector(inputSelector);
    const preview = document.querySelector(previewSelector);

    if (input && preview) {
      input.addEventListener("change", function (e) {
        const file = e.target.files[0];
        if (file) {
          const reader = new FileReader();
          reader.onload = function (event) {
            preview.src = event.target.result;
            preview.classList.remove("d-none");
          };
          reader.readAsDataURL(file);
        }
      });
    }
  };

  // 投稿用
  previewImage("#post_image", "#post-image-preview");
  // レビュー用
  previewImage("#review_image", "#review-image-preview");
  // マイページや場所・イベントの画像入力も同様にIDで呼び出す
  previewImage("#place_image", "#place-image-preview");
  previewImage("#event_image", "#event-image-preview");
});