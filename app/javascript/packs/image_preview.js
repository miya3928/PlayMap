document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll("input[type='file'][id$='_image']").forEach((input) => {
    const previewId = `${input.id}_preview`;
    const preview = document.getElementById(previewId);

    if (preview) {
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
  });
});