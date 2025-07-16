document.addEventListener("turbolinks:load", () => {
  const elem = document.querySelector("#review-score-form");
  const input = document.querySelector("#score-input");

  if (elem && input && typeof window.raty === "function") {
    const score = parseFloat(elem.dataset.score) || 0;

    window.raty(elem, {
      score: score,
      number: 5,
      half: true,
      starOn: elem.dataset.starOn,
      starOff: elem.dataset.starOff,
      starHalf: elem.dataset.starHalf,
      click: function(score) {
        input.value = score;
      }
    });
  }
});