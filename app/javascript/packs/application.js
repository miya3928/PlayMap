import Rails from "@rails/ujs";
import Turbolinks from "turbolinks";
import * as ActiveStorage from "@rails/activestorage";
import "bootstrap";

import "select2/dist/js/select2.min";
import "../stylesheets/application";

import Swiper from 'swiper';
import { Navigation, Pagination } from 'swiper/modules';
// import Swiper and modules styles
// import 'swiper/css';
// import 'swiper/css/navigation';
// import 'swiper/css/pagination';


// 各コンポーネント
import "./filters.js";
import "./flash.js";
import "./hero_swiper.js";
import "./image_preview.js";
import "./jpostal.js";
import "./map.js";
import "./page_top.js";
import "./post_form_modal.js";
import "./post.js";
import "./raty_display.js";
import "./raty_form.js";
import "./reply.js";
import "./search_toggle.js";

// Raty
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