document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll(".review-score-static:not(.raty-applied)").forEach((elem) => {
    const score = parseFloat(elem.dataset.score);
    const starOn = elem.dataset.starOn;
    const starOff = elem.dataset.starOff;
    const starHalf = elem.dataset.starHalf;

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