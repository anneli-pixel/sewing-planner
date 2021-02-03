const makePatternCardClickable = () => {
  const patternCardContainer = document.querySelectorAll(".wrapper-pattern-show-page");
  patternCardContainer.forEach((patternCard) => {
    const titleLink = patternCard.firstElementChild.firstElementChild.firstElementChild;
    patternCard.addEventListener("click", () => {
        titleLink.click()
    });
  });
}

export { makePatternCardClickable };
