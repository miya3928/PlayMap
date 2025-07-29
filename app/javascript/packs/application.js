// import $ from 'jquery';
// window.$ = $;
// window.jQuery = $;

import 'select2/dist/js/select2.min';
import 'select2/dist/css/select2.min.css';

import 'bootstrap';
import "../stylesheets/application";

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";

import "./filters.js";
import "./flash.js";
import "./image_preview.js";
import "./jpostal.js";
import "./map.js";
import "./post_form_modal.js";
import "./post.js";
import "./raty_display.js";
import "./raty_form.js";
import "./reply.js";


import Raty from "../lib/raty.js";
window.raty = function (elem, opt) {
  let raty = new Raty(elem, opt);
  raty.init();
  return raty;
};

Rails.start();
Turbolinks.start();
ActiveStorage.start();

function autoCloseFlashMessages() {
  $('.message').each(function () {
    const alert = $(this);
    setTimeout(() => {
      alert.fadeOut('slow', function () {
        $(this).remove();
      });
    }, 5000);
  });
}

document.addEventListener('turbolinks:load', () => {
  console.log('Flash script loaded');
  autoCloseFlashMessages();
});

window.autoCloseFlashMessages = autoCloseFlashMessages; // JS内で再利用できるように