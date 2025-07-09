document.addEventListener("turbolinks:load", () => {
  const $elem = $("#review-score");
  const $scoreInput = $("#score-input");

  if ($elem.length && $scoreInput.length) {
    $elem.raty({
      scoreName: "review[score]",
      number: 5,
      half: true,
      starOn: "/assets/star-on.png",
      starOff: "/assets/star-off.png",
      starHalf: "/assets/star-half.png",
      score: $scoreInput.val() || 0,
      click: function(score) {
        $scoreInput.val(score);
      },
    });
  }
});