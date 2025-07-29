function autoCloseFlashMessages() {
  $('.message').each(function () {
    const alert = $(this);
    setTimeout(() => {
      alert.fadeOut('slow', function () {
        $(this).remove();
      });
    }, 3000);
  });
}

document.addEventListener('turbolinks:load', () => {
  autoCloseFlashMessages();
});

// 他JSから使えるようにexport
window.autoCloseFlashMessages = autoCloseFlashMessages;