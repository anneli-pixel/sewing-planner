const getPhotoUrlforPattern = () => {
  const pageId = document.querySelector('.page-container').id;
  if (pageId === 'patterns-index') {
    const patternWrappers = document.querySelectorAll('.wrapper-pattern-card');

    patternWrappers.forEach((wrapper) => {
      const url = wrapper.dataset.image;
      if (url === "no_image") {

      } else {
        wrapper.style.backgroundImage = `url(${url})`;
        wrapper.classList.add("pattern-image-card-background");
      }
    })
  }
}

export { getPhotoUrlforPattern };
