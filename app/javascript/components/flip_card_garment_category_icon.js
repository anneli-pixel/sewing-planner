const addFlipCardClassesForGarmentCategoryIcon = () => {
  const flipCards = document.querySelectorAll(".category-item");
  flipCards.forEach((flipCard) => {
    flipCard.classList.add('flip-card');
  })

  const innerFlipCards = document.querySelectorAll('.flip-card > label');
  innerFlipCards.forEach((innerFlipCard) => {
    innerFlipCard.classList.add('flip-card-inner');
  })
}

export { addFlipCardClassesForGarmentCategoryIcon };