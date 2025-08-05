document.addEventListener('turbolinks:load', function () {
  $('#page-top a').on('click', function (event) {
    event.preventDefault();
    $('html, body').animate({ scrollTop: 0 }, 800);
  });
});