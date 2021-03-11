const selectActiveFilter = () => {
  const queryString = window.location.search;
  if (queryString) {
    const urlParams = new URLSearchParams(queryString);

    const garmentCategoryFilter = urlParams.get('garment_category_filter');

    const selectedGarmentCategoryImage = document.getElementById(garmentCategoryFilter);
    selectedGarmentCategoryImage.classList.add("selected");
  }
}

export { selectActiveFilter };
