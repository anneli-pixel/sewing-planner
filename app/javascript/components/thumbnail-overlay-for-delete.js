const thumbnailOverlayForDelete = () => {

  const pageId = document.querySelector('body').children[1].id;
  const pageIdsWithThumbnails = ['projects-edit', 'projects-new', 'patterns-edit', 'patterns-new'];

  if (pageIdsWithThumbnails.includes(pageId)) {
    const thumbnailOverlay = document.querySelector('.thumbnail-overlay');
    const deleteButton = document.querySelector('.delete-button');
  
    deleteButton.addEventListener(('click'), () => {
        thumbnailOverlay.classList.toggle('selected');
    });
  }
}

export { thumbnailOverlayForDelete };