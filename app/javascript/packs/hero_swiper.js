import Swiper from "swiper";

document.addEventListener("turbo:load", () => {
  const swiperEl = document.querySelector(".hero-swiper");
  if (!swiperEl) return;

  new Swiper(".hero-swiper", {
    loop: true,
    autoplay: { delay: 5000 },
    speed: 1400,
    effect: "fade",
  });
});