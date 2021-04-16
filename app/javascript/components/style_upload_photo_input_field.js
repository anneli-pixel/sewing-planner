const styleUploadPhotoInputField = () => {

  const pageId = document.querySelector('body').children[1].id;
  const pageIdsWithUploadButtons = ['projects-edit', 'projects-new', 'patterns-edit', 'patterns-new'];

  if (pageIdsWithUploadButtons.includes(pageId)) {
    const modelName = findModel(pageId);
    const photoInputWrapper = document.querySelector(`.${modelName}_photo`);
    const photoInput = document.getElementById(`${modelName}_photo`);
    const styledButton = document.createElement('label');
    const currentFileName = document.getElementById('photo-file-name');

    addStyledUploadButton(modelName, photoInputWrapper, styledButton);

    if (currentFileName) {
      displayCurrentFileName(photoInputWrapper, currentFileName);
    }

    photoInput.addEventListener(('change'), () => displayUpdatedFileName(photoInputWrapper, photoInput));
  }
}

function addStyledUploadButton(modelName, wrapperElement, buttonElement) {
  buttonElement.classList.add('file', 'optional', 'btn-basic', 'btn-light-blue-solid');
  buttonElement.setAttribute('for', `${modelName}_photo`);
  buttonElement.innerHTML = 'Upload Photo';
  wrapperElement.appendChild(buttonElement);
}

function displayCurrentFileName(wrapperElement, currentFileName) {
  wrapperElement.appendChild(currentFileName);
}

function displayUpdatedFileName(wrapperElement, photoInput) {
  if (wrapperElement.lastElementChild.tagName === 'SPAN') {
    wrapperElement.removeChild(wrapperElement.lastElementChild);
  };

  const fileName = document.createElement('span');
  fileName.classList.add('small-text');
  fileName.innerHTML = `${photoInput.files[0].name}`;
  wrapperElement.appendChild(fileName);
}

function findModel(pageIdentifier) {
  if (pageIdentifier.includes('projects')) {
    return 'project';
  } else if (pageIdentifier.includes('patterns')) {
    return 'pattern';
  }
}

export { styleUploadPhotoInputField };
