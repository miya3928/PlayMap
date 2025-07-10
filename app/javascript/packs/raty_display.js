document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll(".review-score:not(.raty-applied)").forEach((elem) => {
    const score = parseFloat(elem.dataset.score);

    raty(elem, {
      readonly: true,
      score: score,
      number: 5,
      starOn: "/assets/star-on.png",
      starOff: "/assets/star-off.png",
      starHalf: "/assets/star-half.png",
    });

    elem.classList.add('raty-applied'); // 適用済みの要素にクラスを付与
    elem.querySelectorAll('img').forEach((star) => {
      star.style.pointerEvents = 'none'; // 星マーク画像のクリックイベントを無効化
    });
  });
});