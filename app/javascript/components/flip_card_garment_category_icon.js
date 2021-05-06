const addFlipCardClassesForGarmentCategoryIcon = () => {
  const pageId = document.querySelector('body').children[1].id;
  const pageIdsWithFlipCards = ['patterns-edit', 'patterns-new', 'patterns-create', 'patterns-update'];

  if (pageIdsWithFlipCards.includes(pageId)) {
    const flipCards = document.querySelectorAll(".category-item");
    flipCards.forEach((flipCard) => {
      flipCard.classList.add('flip-card');
    });

    const innerFlipCards = document.querySelectorAll('.flip-card > label');
    innerFlipCards.forEach((innerFlipCard) => {
      innerFlipCard.classList.add('flip-card-inner');
    });
  }
}

export { addFlipCardClassesForGarmentCategoryIcon };