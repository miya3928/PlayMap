document.addEventListener("turbolinks:load", () => {
  document.querySelectorAll(".review-score:not(.raty-applied)").forEach((elem) => {
    const score = parseFloat(elem.dataset.score);
    if (isNaN(score)) return;

    $(elem).raty({
      readOnly: true,
      score: score,
      number: 5,
      half: true,
      starOn: "/assets/star-on.png",
      starOff: "/assets/star-off.png",
      starHalf: "/assets/star-half.png",
    });

    elem.classList.add("raty-applied");
    elem.querySelectorAll("img").forEach((star) => {
      star.style.pointerEvents = "none";
    });
  });
});