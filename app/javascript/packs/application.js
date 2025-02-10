import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "popper.js";
import "bootstrap";
import "../stylesheets/application";

import Raty from "../lib/raty.js";
window.raty = function (elem, opt) {
  let raty = new Raty(elem, opt);
  raty.init();
  return raty;
};

import $ from 'jquery';
window.$ = $;
window.jQuery = $;

import "../filters";

Rails.start()
Turbolinks.start()
ActiveStorage.start()