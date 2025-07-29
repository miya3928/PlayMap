import 'select2/dist/js/select2.min';
import 'select2/dist/css/select2.min.css';

import 'bootstrap';
import "../stylesheets/application";

import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";

// 各コンポーネント
import "./filters.js";
import "./flash.js"; // Flash ロジックを分離してここに記述
import "./image_preview.js";
import "./jpostal.js";
import "./map.js";
import "./post_form_modal.js";
import "./post.js";
import "./raty_display.js";
import "./raty_form.js";
import "./reply.js";

// Raty ラッパー
import Raty from "../lib/raty.js";
window.raty = function (elem, opt) {
  let raty = new Raty(elem, opt);
  raty.init();
  return raty;
};

// 初期化
Rails.start();
Turbolinks.start();
ActiveStorage.start();