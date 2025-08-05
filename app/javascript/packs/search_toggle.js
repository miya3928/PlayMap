$(document).on('turbolinks:load', function () {
  $('#searchToggle').on('click', function () {
    $('#searchFormWrapper').toggleClass('d-none');
  });
});