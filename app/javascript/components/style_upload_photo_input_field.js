const styleUploadPhotoInputField = () => {

  const pageId = document.querySelector('body').children[1].id;
  const pageIdsWithUploadButtons = ['projects-edit', 'projects-new', 'patterns-edit', 'patterns-new'];

  if (pageIdsWithUploadButtons.includes(pageId)) {
    const modelName = findModel(pageId);
    const photoInputWrapper = document.querySelector(`.${modelName}_photo`);
    const photoInput = document.getElementById(`${modelName}_photo`);
    const styledUploadButton = document.createElement('label');
    const deleteButton = document.querySelector(`.${modelName}_delete_photo`);
    const buttonWrapper = document.querySelector('.delete-and-upload-btns');
    const imageThumbnail = document.querySelector('.image-thumbnail');

    addStyledUploadButton(modelName, buttonWrapper, styledUploadButton, imageThumbnail);
    showOrHideDeleteButton(deleteButton, imageThumbnail);

    photoInput.addEventListener(('change'), () => {
      displayUpdatedThumbnail(photoInputWrapper, photoInput, imageThumbnail, event);
    });

    imageThumbnail.addEventListener(('load'), () => {
      addStyledUploadButton(modelName, buttonWrapper, styledUploadButton, imageThumbnail);
      showOrHideDeleteButton(deleteButton, imageThumbnail);
    })
  }
}

function addStyledUploadButton(modelName, wrapperElement, buttonElement, thumbnail) {
  buttonElement.classList.add('file', 'optional', 'btn-basic', 'btn-light-blue-solid');
  buttonElement.setAttribute('for', `${modelName}_photo`);
  if (imageThumbnailDoesNotExist(thumbnail)) {
    buttonElement.innerHTML = 'Upload Photo';
  } else {
    buttonElement.innerHTML = 'Replace Photo';
  };
  wrapperElement.appendChild(buttonElement);
}

function showOrHideDeleteButton(button, thumbnail) {
  if (imageThumbnailDoesNotExist(thumbnail)) {
    button.style.display = "none";
  } else {
    button.style.display = 'initial';
  }

  function imageThumbnailDoesNotExist(thumbnail) {
    if (window.getComputedStyle(thumbnail).display === 'none') {
      return true
    }
  }
}

function displayUpdatedThumbnail(wrapperElement, photoInput, thumbnail, event) {
  const files = event.target.files;
  const image = files[0];
  const reader = new FileReader();
  reader.onload = function(file) {
    const img = new Image();
    img.src = file.target.result;
    thumbnail.setAttribute('src', img.src);
    thumbnail.style.display = "initial";
  }
  reader.readAsDataURL(image);
}

function imageThumbnailDoesNotExist(thumbnail) {
  if (window.getComputedStyle(thumbnail).display === 'none') {
    return true
  }
}

function findModel(pageIdentifier) {
  if (pageIdentifier.includes('projects')) {
    return 'project';
  } else if (pageIdentifier.includes('patterns')) {
    return 'pattern';
  }
}

export { styleUploadPhotoInputField };
