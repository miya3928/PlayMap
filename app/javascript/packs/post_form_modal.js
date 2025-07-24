document.addEventListener("turbolinks:load", () => {
  const postableTypeSelect = document.querySelector("select[name='post[postable_type]']");
  const placeSelection = document.getElementById("place-selection");
  const eventSelection = document.getElementById("event-selection");

  if (!postableTypeSelect) return;

  const toggleSelection = () => {
    const selectedValue = postableTypeSelect.value;
    placeSelection.style.display = selectedValue === "Place" ? "block" : "none";
    eventSelection.style.display = selectedValue === "Event" ? "block" : "none";
  };

  postableTypeSelect.addEventListener("change", toggleSelection);
  toggleSelection();
});

document.addEventListener("turbolinks:load", () => {
  $('.select2').select2({
    width: '100%',
    placeholder: "場所を検索・選択",
    allowClear: true
  });
});

// モーダル初期化（任意）
document.addEventListener("turbolinks:load", () => {
  $('#addPlaceModal').on('show.bs.modal', function (event) {
    const button = $(event.relatedTarget);
    const prefecture = button.data('place-prefecture');
    const modal = $(this);

    if (prefecture) modal.find('input[name="place[prefecture]"]').val(prefecture);
  });

  $('#addEventModal').on('show.bs.modal', function (event) {
    const button = $(event.relatedTarget);
    const eventTitle = button.data('event-title');
    const eventBody = button.data('event-body');
    const modal = $(this);

    if (eventTitle) modal.find('input[name="event[title]"]').val(eventTitle);
    if (eventBody) modal.find('textarea[name="event[body]"]').val(eventBody);
  });
});