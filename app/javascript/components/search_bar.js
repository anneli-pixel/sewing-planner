const selectActiveFilter = () => {
  const queryString = window.location.search;
  if (queryString) {
    console.log(queryString);

    const urlParams = new URLSearchParams(queryString);

    const garmentCategoryFilter = urlParams.get('garment_category_filter');
    console.log(garmentCategoryFilter);

    const normalisedGarmentCategoryFilter = garmentCategoryFilter.toLowerCase().replace("/", "_");

    const garmentCategory = document.getElementById(normalisedGarmentCategoryFilter);
    console.log(garmentCategory)
    garmentCategory.nextElementSibling.firstElementChild.classList.add("selected");
  }
}

export { selectActiveFilter };
