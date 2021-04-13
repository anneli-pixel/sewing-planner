const fitProjectPhotoDependingOnImageRatio = () => {
  const image = document.querySelector('.project_photo');

  if (image) {
    image.addEventListener('load', () => fitImage(image));

    if (image.complete && image.naturalWidth !== 0)
      fitImage(image);

    function fitImage(image) {
      const aspectRatio = image.naturalWidth / image.naturalHeight;

      // If image is landscape
      if (aspectRatio > 1) {
        image.classList.add("landscape");
      }

      // If image is portrait
      else if (aspectRatio < 1) {
        image.classList.add("portrait");
      }
      // If image is sqaure
      else {
        image.classList.add("square");
      }
    }
  }
}

export { fitProjectPhotoDependingOnImageRatio };
