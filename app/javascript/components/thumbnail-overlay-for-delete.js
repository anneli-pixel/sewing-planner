const thumbnailOverlayForDelete = () => {
  const thumbnailOverlay = document.querySelector('.thumbnail-overlay');
  const deleteButton = document.querySelector('.delete-button');

  deleteButton.addEventListener(('click'), () => {
      thumbnailOverlay.classList.toggle('selected');
  });
}

export { thumbnailOverlayForDelete };