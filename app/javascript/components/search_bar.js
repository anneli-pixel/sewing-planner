const selectActiveFilter = () => {
  const filter = window.location.search;
  if (filter) {
    const urlParams = new URLSearchParams(filter);
    selectGarmentCategoryIn(urlParams);
    selectFabricTypeIn(urlParams);
  }
}

const selectGarmentCategoryIn = (urlParams) => {
  const garmentCategoryFilter = urlParams.get('garment_category_filter');
  if (garmentCategoryFilter) {
  const selectedGarmentCategoryImage = document.getElementById(garmentCategoryFilter);
  const allLabel = document.getElementById("label-garment-category-all");
  selectedGarmentCategoryImage.classList.add("selected");
  allLabel.classList.remove("selected");
  }
}

 const selectFabricTypeIn = (urlParams) => {
  const fabricTypeFilter = urlParams.get('fabric_type_filter');
  if (fabricTypeFilter) {
    const selectedFabricTypeLabel = document.getElementById(`label-${fabricTypeFilter}`);
    const allLabel = document.getElementById("label-fabric-type-all");
    console.log(selectedFabricTypeLabel);
    selectedFabricTypeLabel.classList.add("selected");
    allLabel.classList.remove("selected");
  }
}

export { selectActiveFilter };
