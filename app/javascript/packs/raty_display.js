document.addEventListener("turbolinks:load", () => {
  AOS.init({
    duration: 1000, // アニメーションの時間（ミリ秒）
    once: true, // 一度だけアニメーションを実行
  });
});

document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll(".review-score:not(.raty-applied)").forEach((elem) => {
    const score = parseFloat(elem.dataset.score);
    const starOn = "<%= asset_path('star-on.png') %>";
    const starOff = "<%= asset_path('star-off.png') %>";
    const starHalf = "<%= asset_path('star-half.png') %>";
    raty(elem, {
      readonly: true,
      score: score,
      number: 5,
      starOn: starOn,
      starOff: starOff,
      starHalf: starHalf,
    });
    elem.classList.add('raty-applied');
    elem.querySelectorAll('img').forEach((star) => {
      star.style.pointerEvents = 'none';
    });
  });
});

