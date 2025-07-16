document.addEventListener("turbolinks:load", () => {
  const elem = document.querySelector("#review-score-form");
  const input = document.querySelector("#score-input");

  if (elem && input) {
    window.raty(elem, {
      score: parseFloat(input.value || 0),
      number: 5,
      half: true,
      starOn: "/assets/star-on.png",
      starOff: "/assets/star-off.png",
      starHalf: "/assets/star-half.png",
      click: function(score) {
        input.value = score;
      }
    });
  }
});