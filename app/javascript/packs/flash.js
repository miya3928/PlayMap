document.addEventListener('turbolinks:load', () => {
  console.log('Flash script loaded');
  $('.message').each(function () {
    const alert = $(this);
    console.log('Alert will close in 5s');
    setTimeout(() => {
      alert.fadeOut('slow', function () {
        $(this).remove();
      });
    }, 5000);
  });
});