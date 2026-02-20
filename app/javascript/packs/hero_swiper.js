import Swiper from 'swiper';
import { Autoplay, EffectFade } from 'swiper/modules';

// 使用する機能を登録
Swiper.use([Autoplay, EffectFade]);

// Turbolinks環境
document.addEventListener("turbolinks:load", () => {
  const swiperEl = document.querySelector(".hero-swiper");
  if (!swiperEl) return;

  new Swiper(".hero-swiper", {
    loop: true,
    speed: 2000,
    effect: "fade",
    fadeEffect: {
      crossFade: true
    },
    autoplay: {
      delay: 4000,
      disableOnInteraction: false,
    },
  });
});