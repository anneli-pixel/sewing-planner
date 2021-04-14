const styleUploadPhotoInputField = () => {

  const pageId = document.querySelector('body').children[1].id;

  if (pageId === 'projects-edit' || pageId === 'projects-new') {
    const photoInputWrapper = document.querySelector('.project_photo');
    const styledButton = document.createElement('label');
    const photoInput = document.getElementById('project_photo');
    const currentFileName = document.getElementById('project-photo-file-name');

    addStyledUploadButton(photoInputWrapper, styledButton);

    if (currentFileName) {
      displayCurrentFileName(photoInputWrapper, currentFileName);
    }

    photoInput.addEventListener(('change'), () => displayUpdatedFileName(photoInputWrapper, photoInput));
  }
}

function addStyledUploadButton(wrapperElement, buttonElement) {
  buttonElement.classList.add('file', 'optional', 'btn-basic', 'btn-light-blue-solid');
  buttonElement.setAttribute('for', 'project_photo');
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

export { styleUploadPhotoInputField };
